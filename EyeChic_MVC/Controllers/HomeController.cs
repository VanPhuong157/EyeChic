using EyeChic_MVC.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Threading.Tasks;

namespace EyeChic_MVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly HttpClient _client;
        private readonly string _productUrl = "http://localhost:5209/api/Products";
        private readonly string _categoryUrl = "http://localhost:5209/api/Categories";

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
            _client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            _client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        public async Task<ActionResult> Index()
        {
            try
            {
                HttpResponseMessage response = await _client.GetAsync(_productUrl);
                response.EnsureSuccessStatusCode();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };
                string strData = await response.Content.ReadAsStringAsync();
                List<Product> products = JsonSerializer.Deserialize<List<Product>>(strData, options);
                foreach (var product in products)
                {
                    HttpResponseMessage categoryResponse = await _client.GetAsync($"{_categoryUrl}/{product.CategoryId}");
                    if (categoryResponse.IsSuccessStatusCode)
                    {
                        string categoryStrData = await categoryResponse.Content.ReadAsStringAsync();
                        Category category = JsonSerializer.Deserialize<Category>(categoryStrData, options);

                        if (product.Category == null)
                        {
                            product.Category = new Category();
                        }

                        product.Category = category;
                    }
                }
                return View(products);
            }
            catch
            {
                return NoContent();
            }
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
