//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Objects;
using System.Data.EntityClient;

namespace QuestionsYourFriendsDataAccess
{
    public partial class QuestionYourFriendsEntities : ObjectContext
    {
        public const string ConnectionString = "name=QuestionYourFriendsEntities";
        public const string ContainerName = "QuestionYourFriendsEntities";
    
        #region Constructors
    
        public QuestionYourFriendsEntities()
            : base(ConnectionString, ContainerName)
        {
            this.ContextOptions.LazyLoadingEnabled = true;
        }
    
        public QuestionYourFriendsEntities(string connectionString)
            : base(connectionString, ContainerName)
        {
            this.ContextOptions.LazyLoadingEnabled = true;
        }
    
        public QuestionYourFriendsEntities(EntityConnection connection)
            : base(connection, ContainerName)
        {
            this.ContextOptions.LazyLoadingEnabled = true;
        }
    
        #endregion
    
        #region ObjectSet Properties
    
        public ObjectSet<Question> Questions
        {
            get { return _questions  ?? (_questions = CreateObjectSet<Question>("Questions")); }
        }
        private ObjectSet<Question> _questions;
    
        public ObjectSet<Transac> Transacs
        {
            get { return _transacs  ?? (_transacs = CreateObjectSet<Transac>("Transacs")); }
        }
        private ObjectSet<Transac> _transacs;
    
        public ObjectSet<User> Users
        {
            get { return _users  ?? (_users = CreateObjectSet<User>("Users")); }
        }
        private ObjectSet<User> _users;

        #endregion
    }
}
