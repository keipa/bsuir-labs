using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using WebAPI.Encrypt;

namespace WebAPI.Controllers
{
    [Route("api/[controller]")]
    public class DES3Controller : Controller
    {
       


        private static readonly DES3 des3 = new Encrypt.DES3();

        private readonly Dictionary<string, Delegate> algorithmType = new Dictionary<string, Delegate>
        {
            {"encrypt", new Func<string, string>(des3.Encrypt)},
            {"decrypt", new Func<string, string>(des3.Decrypt)}
        };

        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "DES 3 round Encryption Algorithm" };
        }

        // GET api/values/5
        [HttpGet("{sourceString}/{procedureType}")]
        public string Get(string sourceString, string procedureType)
        {
            if (algorithmType.Keys.All(x => x != procedureType))
            {
                return ($"{procedureType} is not valid procedureType");
            }
            return (string)algorithmType[procedureType].DynamicInvoke(sourceString);
        }


    }


    }
