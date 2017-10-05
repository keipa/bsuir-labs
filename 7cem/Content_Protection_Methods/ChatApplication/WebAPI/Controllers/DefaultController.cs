using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebAPI.Encrypt;

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
