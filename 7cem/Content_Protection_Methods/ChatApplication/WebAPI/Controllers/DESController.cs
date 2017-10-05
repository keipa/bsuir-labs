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
    public class DESController : Controller
    {
       


        private static readonly Encrypt.DES des = new Encrypt.DES();

        private readonly Dictionary<string, Delegate> algorithmType = new Dictionary<string, Delegate>
        {
            {"encrypt", new Func<string, string>(des.Encrypt)},
            {"decrypt", new Func<string, string>(des.Decrypt)}
        };

        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "DES Encryption Algorithm" };
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
