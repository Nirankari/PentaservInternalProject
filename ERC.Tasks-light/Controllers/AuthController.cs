using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Domain;
using Dapper;
using System.Data.SqlClient;
using System.Web.Http.Cors;

namespace ERC.Tasks_light.Controllers
{
   
    public class AuthController : ApiController
    {
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        public class UserLoginInfo
        {
            public string UserName;
            public string Password;
        }

        [HttpPost]
        [Route("api/Auth/Login")]
        public User Login(UserLoginInfo loginInfo)
        {
            var user = UserManager.Login(loginInfo.UserName, loginInfo.Password);
            System.Web.HttpContext.Current.Session["signed"] = user;
            return user;
        }

        [HttpGet]
        [Route("api/Auth/IsLoggedIn")]
        public User IsLoggedIn()
        {
            return (System.Web.HttpContext.Current.Session["signed"] != null ? (User)System.Web.HttpContext.Current.Session["signed"] : null);
        }
        //Api for logout
        [HttpGet]
        [Route("api/Auth/Logout")]
        public bool Logout()
        {
           
           System.Web.HttpContext.Current.Session["signed"] = null;
           return true;
        }
        // POST: api/Tasks
        [System.Web.Http.Route("api/Auth/CreateUser")]
        [System.Web.Http.HttpPost]
        public int CreateUser(User _obj)
        {
            try
            {
                return UserManager.CreateUser(_obj);

            }
            catch (Exception ex) { return 0; }
        }
       
    }
}
