using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.DirectoryServices.AccountManagement;
using Dapper;
using System.Data.SqlClient;
using System.Configuration;

namespace Domain
{
    public static class UserManager
    {
        private static readonly string ConnectionString = ConfigurationManager.AppSettings.Get("Connection");

        public static User Login(string userName, string password)
        {
            User admuser = new User();
                         using (var db = new SqlConnection(ConnectionString))
                         {

                             var q = @"SELECT U.DisplayName,u.UserName,u.UserRole,U.UserId,U.Email
                                     FROM [collect2000].[ERCTasks].[UserCredential] AS UC WITH(NOLOCK) JOIN [collect2000].[ERCTasks].[Users] AS U
                                      WITH(NOLOCK) ON U.UserName=@UserName AND UC.Password=@Password AND isActive=1";
                             admuser = db.Query<User>(q, new { UserName = userName, Password = password }).SingleOrDefault();
                           
                         }
                         return admuser;

            //using (var context = new PrincipalContext(ContextType.Domain, "erccollections.com"))
            //{
            //    var usr = UserPrincipal.FindByIdentity(context, userName);
            //    if (usr != null)
            //    {
            //        var verified = context.ValidateCredentials(userName, password);
            //        if (verified)
            //        {
            //            using (var conn = new SqlConnection(ConnectionString))
            //            {
            //                conn.Open();
            //                var user =
            //                    conn.Query<User>(
            //                        "select * from [collect2000].[ERCTasks].[Users] WHERE UserName = @userName",
            //                        new { userName = userName }).FirstOrDefault();
            //                if (user == null)
            //                {
            //                    var userId = conn.ExecuteScalar<int>(
            //                        "INSERT INTO [collect2000].[ERCTasks].[Users] (UserName, DisplayName, Email) VALUES (@userName, @dispName, @email); SELECT SCOPE_IDENTITY();",
            //                        new { userName = userName, dispName = usr.DisplayName, email = usr.EmailAddress });
            //                    user = new User()
            //                    {
            //                        DisplayName = usr.DisplayName,
            //                        UserName = userName,
            //                        UserRole = "user",
            //                        UserId = userId,
            //                        Email = usr.EmailAddress
            //                    };
            //                }
            //                return user;
            //            }
            //        }
            //    }
            //}
           // return null;
        }

        public static User GetUserDetails(string username)
        {
            User _objUser = new User();

            using (var db = new SqlConnection(ConnectionString))
            {

                var q = @"SELECT U.DisplayName,u.UserName,u.UserRole,U.Email
                                     FROM [collect2000].[ERCTasks].[UserCredential] AS UC WITH(NOLOCK) JOIN [collect2000].[ERCTasks].[Users] AS U
                                      WITH(NOLOCK) ON U.UserName=@UserName";
                var usr = db.Query<User>(q, new { UserName = username }).FirstOrDefault();
                if (usr != null)
                {

                    _objUser.DisplayName = usr.DisplayName;
                    _objUser.UserName = username;
                    _objUser.Email = usr.Email;
                    _objUser.UserRole = "user";
                }

            }
            return _objUser;
            //User _objUser = new User();
            //using (var context = new PrincipalContext(ContextType.Domain, "erccollections.com"))
            //{
            //    var usr = UserPrincipal.FindByIdentity(context, username);
            //    if (usr != null)
            //    {
                    
            //        _objUser.DisplayName = usr.DisplayName;
            //        _objUser.UserName = username;
            //        _objUser.Email = usr.EmailAddress;
            //        _objUser.UserRole = "user";
            //    }
            //}
            //return _objUser;
        }
        public static int CreateUser(User user)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                db.Open();
                var q1 = @"IF NOT EXISTS (SELECT * FROM [collect2000].[ERCTasks].[UserCredential] WHERE UserName=@UserName AND Password =@Password) BEGIN INSERT INTO [collect2000].[ERCTasks].[UserCredential] (UserName, Password, isActive) VALUES (@UserName,@Password,1);SELECT SCOPE_IDENTITY();END";
                int returnId = db.Query<int>(q1, new
                {
                    @UserName = user.UserName,
                    @Password = user.Password
                }).FirstOrDefault<int>();
                if (returnId != 0)
                {
                    var q = @"INSERT INTO [collect2000].[ERCTasks].[Users] 
                                       (UserId,UserRole, UserName, DisplayName, Email,CreatedDate)
                                        VALUES (@UserId,@UserRole,@UserName,@DisplayName,@Email,getdate());";
                    db.Query<int>(q, new
                    {
                        @UserId = returnId,
                        @UserRole = user.UserRole,
                        @UserName = user.UserName,
                        @DisplayName = user.DisplayName,
                        @Email = user.Email
                    });
                }
               
                return 1;
            }
        }
      
    }
}