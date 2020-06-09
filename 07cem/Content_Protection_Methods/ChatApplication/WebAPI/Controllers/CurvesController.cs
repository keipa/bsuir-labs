using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using WebAPI.Encrypt;


namespace WebAPI.Controllers
{

    [Route("api/[controller]")]
    public class CurvesController : Controller
    {
        private readonly Dictionary<string, Delegate> algorithmType = new Dictionary<string, Delegate> { };

        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] {"Curves Encryption Algorithm"};
        }

        // GET api/values/5
        [HttpGet("{sourceString}/{procedureType}")]
        public string Get(string sourceString, string procedureType)
        {
            if (algorithmType.Keys.All(x => x != procedureType))
            {
                return ($"{procedureType} is not valid procedureType");
            }
            return (string) algorithmType[procedureType].DynamicInvoke(sourceString);

        }
    }

}