﻿using QuestionYourFriendsDataAccess;

namespace QuestionYourFriends.BusinessManagement
{
    /// <summary>
    /// EntityContext
    /// </summary>
    public static class Context
    {
        /// <summary>
        /// Static instance of our Entity context
        /// </summary>
        public static readonly QuestionYourFriendsEntities QyfEntities = new QuestionYourFriendsEntities();
    }
}