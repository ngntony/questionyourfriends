﻿using System.Web.Mvc;

namespace QuestionYourFriends.Controllers
{
    /// <summary>
    /// Ask pages controller
    /// </summary>
    public class AskController : Controller
    {
        /// <summary>
        /// GET: /Ask/
        /// </summary>
        public ActionResult Index()
        {
            dynamic result = Session["user"];

            if (result == null)
                return RedirectToAction("Index", "Home");

            ViewData["Firstname"] = result.first_name;
            ViewData["Lastname"] = result.last_name;
            ViewData["Message"] = "Bienvenue sur QuestionYourFriends !";
           
            return View();
        }

        public ActionResult Ask()
        {
            string asked_friend = this.Request.Params.Get("friend_sel");
            string asked_question = this.Request.Params.Get("ask");
            string private_cost_question = this.Request.Params.Get("private_cost");
            string annon_cost_question = this.Request.Params.Get("annon_cost");
            dynamic user = Session["user"];
            long fid = long.Parse(user.id);
            if (private_cost_question == null)
                private_cost_question = "0";
            if (annon_cost_question == null)
                annon_cost_question = "0";
            int private_cost = int.Parse(private_cost_question);
            int annon_cost = int.Parse(annon_cost_question);
            long ffid = long.Parse(asked_friend);
            QuestionYourFriendsDataAccess.User me = BusinessManagement.User.Get(fid);
            if (me.credit_amount > (annon_cost + private_cost))
            {
                QuestionYourFriendsDataAccess.User friend = BusinessManagement.User.Get(ffid);
                if (friend == null)
                {
                    BusinessManagement.User.Create(ffid);
                    friend = BusinessManagement.User.Get(ffid);
                }
                int qid = BusinessManagement.Question.Create(me.id, friend.id, asked_question, annon_cost, private_cost, System.DateTime.Now);
                QuestionYourFriendsDataAccess.Question q = BusinessManagement.Question.Get(qid);
                BusinessManagement.Transac.SpendAndQuestion(q, me);
            }
            return RedirectToAction("Index", "Ask");
        }
    }
}