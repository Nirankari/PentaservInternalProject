using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.Http;
using System.IO;
using ERC.Tasks_light.Models;

namespace ERC.Tasks_light.Controllers
{
    public class MainController : ApiController
    {
        
        [HttpGet]
        [Route("")]
        public HttpResponseMessage Get()
        {
            return TemplateManager.ServeView("~/Views/index.cshtml");
        }
    }
}
