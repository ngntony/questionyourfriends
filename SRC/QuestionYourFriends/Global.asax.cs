﻿using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace QuestionYourFriends
{
    // Remarque : pour obtenir des instructions sur l'activation du mode classique IIS6 ou IIS7, 
    // visitez http://go.microsoft.com/?LinkId=9394801

    /// <summary>
    /// Our MVC application
    /// </summary>
    public class MvcApplication : HttpApplication
    {
        /// <summary>
        /// Method to register routes
        /// </summary>
        /// <param name="routes"></param>
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Nom d'itinéraire
                "{controller}/{action}/{id}", // URL avec des paramètres
                new {controller = "Home", action = "Index", id = UrlParameter.Optional} // Paramètres par défaut
                );
        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }
    }
}