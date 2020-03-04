using System;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using TensorFlowConnector;

namespace MLApi.Controllers
{
    [Route("/image")]
    public class ValuesController : Controller
    {
        [HttpGet]
        public RedirectResult Get()
        {
            Console.WriteLine("Input");
            return new RedirectResult("/index.html");
        }

        [HttpPost]
        public async Task<IActionResult> Post()
        {
            var filePath = Path.GetTempFileName().Replace(".tmp", ".jpg");
            var t = new TensorFlowConnector.TensorFlowConnector();
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await Request.Body.CopyToAsync(stream);
            }
            return new OkObjectResult(new { @class = t.Call(), path = filePath });
        }
    }
}
