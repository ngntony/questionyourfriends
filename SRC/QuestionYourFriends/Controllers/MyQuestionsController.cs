﻿using System.Reflection;
using System.Web.Mvc;
using System.Collections.Generic;
using log4net;
using QuestionYourFriends.Models;
using Facebook.Web.Mvc;
using System;

namespace QuestionYourFriends.Controllers
{
    /// <summary>
    /// My quesions pages controller
    /// </summary>
    [HandleError]
    public class MyQuestionsController : Controller
    {
        private static readonly ILog _logger = LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// GET: /MyQuestions/
        /// </summary>
        public ActionResult Index()
        {
            return RedirectToAction("ToMe", "MyQuestions");
        }

        /// <summary>
        /// GET: /MyQuestions/ToMe
        /// </summary>
        public ActionResult ToMe()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                // Compute data
                List<QuestionYourFriendsDataAccess.Question> receiver = Question.GetListOfReceiver(uid);
                ViewData["questions"] = receiver;
                ViewData["tab"] = "toMe";
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// GET: /MyQuestions/FromMe
        /// </summary>
        public ActionResult FromMe()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                // Compute data
                List<QuestionYourFriendsDataAccess.Question> toAll = Question.GetListOfOwner(uid);
                ViewData["questions"] = toAll;
                ViewData["tab"] = "fromMe";
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// Answer a question
        /// </summary>
        public ActionResult Answeree()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                // Question update
                string answer = Request.Params.Get("answer");
                string qidstring = Request.Params.Get("qid");
                int qid = int.Parse(qidstring);
                QuestionYourFriendsDataAccess.Question q = Question.Get(qid);
                q.answer = answer;
                q.date_answer = DateTime.Now;
                Question.Update(q);

                // Earning answer transaction
                QuestionYourFriendsDataAccess.User u = Models.User.Get(uid);
                Transac.EarningAnswer(u);
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// Delete a question
        /// </summary>
        /// <param name="qid">Question id</param>
        public ActionResult Delete(int qid)
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                Question.Delete(qid);
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// Cancels an action
        /// </summary>
        public ActionResult Cancel()
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                Request.Params.Set("answer", "qid");
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// Reveals a question
        /// </summary>
        /// <param name="qid">question id</param>
        public ActionResult Reveal(int qid)
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                // Compute data
                QuestionYourFriendsDataAccess.Question question = Question.Get(qid);
                QuestionYourFriendsDataAccess.User user = Models.User.Get(uid);
                Transac.DesanonymizeQuestion(question, user);
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }

        /// <summary>
        /// Deprivatize a question
        /// </summary>
        /// <param name="qid">question id</param>
        public ActionResult ToPublic(int qid)
        {
            try
            {
                // Fetch data
                dynamic uid = Session["uid"];
                dynamic fid = Session["fid"];
                if (uid == null || fid == null)
                    return RedirectToAction("Index", "Home");

                // Compute data
                QuestionYourFriendsDataAccess.Question question = Question.Get(qid);
                QuestionYourFriendsDataAccess.User user = Models.User.Get(uid);
                Transac.DeprivatizeQuestion(question, user);
            }
            catch (ApplicationException e)
            {
                ViewData["Error"] = e.Message;
            }
            return View("Index");
        }
    }
}