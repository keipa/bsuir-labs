using System;
using Microsoft.AspNetCore.Mvc;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    public class DefaultController : Controller
    {
     
        public string Get(string sourceString, string procedureType)
        {
            return $"EncryptAPI is working! {DateTime.Now}";
        }

        
    }
}
