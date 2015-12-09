using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;

namespace ERC.Tasks_light.Models
{
    public static class TemplateManager
    {
        public static HttpResponseMessage ServeView(string view)
        {
            var response = new HttpResponseMessage();
            var viewpath = System.Web.Hosting.HostingEnvironment.MapPath(view);
            var contents = File.ReadAllText(viewpath);
            response.Content = new StringContent(contents, System.Text.Encoding.UTF8, "text/html");
            response.Content.Headers.ContentType = new MediaTypeHeaderValue("text/html");
            return response;
        }
    }
}