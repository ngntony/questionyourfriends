﻿using System;
using System.Reflection;
using System.Web.Mvc;
using log4net;
using QuestionYourFriendsDataAccess;
using Question = QuestionYourFriends.Models.Question;
using Transac = QuestionYourFriends.Models.Transac;

namespace QuestionYourFriends.Controllers
{
    /// <summary>
    /// Ask pages controller
    /// </summary>
    [HandleError]
    public class AskController : Controller
    {
        private static readonly ILog _logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// GET: /Ask/
        /// </summary>
        public ActionResult Index()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                {
                    _logger.InfoFormat("Session fault, uid({0}), fid({1})", Session["uid"], Session["fid"]);
                    return RedirectToAction("Index", "Home");
                }

                // Logging
                MethodBase mb = MethodBase.GetCurrentMethod();
                string folder = mb.DeclaringType.Name;
                folder = folder.Substring(0, folder.Length - 10);
                _logger.InfoFormat("User {0} (FbId: {1}) accessed page {2}/{3}", uid, fid, folder, mb.Name);

                // Infos
                var user = Models.User.Get(uid);
                int nbRemain = QyfData.FreeQuestionPerDay - Transac.GetNumberOfQuestionToday(user);
                string msg = string.Format("You can earn {0} credits each time you ask a question, {1} times a day.",
                                           QyfData.EarningMessage, QyfData.FreeQuestionPerDay);
                msg += nbRemain != 0 ? string.Format(" {0} more today!", nbRemain) : " No more today!";
                ViewData["Info"] = msg;
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
                _logger.Error(e.Message);
            }
            return View();
        }

        /// <summary>
        /// GET: /Ask/Ask
        /// </summary>
        public ActionResult Ask()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                {
                    _logger.InfoFormat("Session fault, uid({0}), fid({1})", Session["uid"], Session["fid"]);
                    return RedirectToAction("Index", "Home");
                }

                // Logging
                MethodBase mb = MethodBase.GetCurrentMethod();
                string folder = mb.DeclaringType.Name;
                folder = folder.Substring(0, folder.Length - 10);
                _logger.InfoFormat("User {0} (FbId: {1}) accessed page {2}/{3}", uid, fid, folder, mb.Name);

                // Fetch parameters
                string askedFriend = Request.Params.Get("friend_sel");
                string askedQuestion = Request.Params.Get("ask");
                string privateCostQuestion = Request.Params.Get("private_cost");
                string annonCostQuestion = Request.Params.Get("annon_cost");
                int privateCost;
                int annonCost;
                long ffid;

                // Check parameters
                if (!long.TryParse(askedFriend, out ffid))
                    throw new ApplicationException("Please select a friend.");
                if (askedQuestion == null)
                    throw new ApplicationException("Please formulate a question.");
                if (!int.TryParse(privateCostQuestion, out privateCost)
                    || !int.TryParse(annonCostQuestion, out annonCost)
                    || privateCost < 0
                    || privateCost > 9999999
                    || annonCost < 0
                    || annonCost > 9999999)
                    throw new ApplicationException("Please enter valid numbers (> 0 and < 9,999,999) for the prices.");

                // Do work
                User me = Models.User.Get(fid);
                if (me.credit_amount > (annonCost + privateCost))
                {
                    User friend = Models.User.Get(ffid);
                    int qid = Question.Create(me.id, friend.id, askedQuestion, annonCost, privateCost, DateTime.Now);
                    QuestionYourFriendsDataAccess.Question q = Question.Get(qid);
                    Transac.SpendAndQuestion(q, me);
                }
                ViewData["Info"] = "Your question has been sent successfully.";

                // Publication sur Fb
                try
                {
                    if (annonCost == 0)
                        Models.Facebook.Publish(ffid, askedQuestion, "https://fbcdn-photos-a.akamaihd.net/photos-ak-snc1/v27562/215/131910193550231/app_1_131910193550231_8016.gif", "http://apps.facebook.com/questionyourfriends/", "Question Your Friend", Models.Facebook.GetFriendName(fid) + " just asked you a question on Question Your Friends! Come on and answer the question!");
                }
                catch (Facebook.FacebookApiException e)
                {
                    _logger.Error(e.Message);
                }
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
                _logger.Error(e.Message);
            }
            return View("Index");
        }
    }
}