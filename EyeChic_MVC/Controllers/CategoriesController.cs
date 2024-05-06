using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EyeChic_MVC.Models;
using System.Net.Http.Headers;
using System.Text.Json;
using System.Text;

namespace EyeChic_MVC.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly HttpClient client;
        private string CategoryUrl = "http://localhost:5209/api/Categories";

        public CategoriesController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        // GET: Categories
        public async Task<IActionResult> Index()
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                try
                {
                    HttpResponseMessage response = await client.GetAsync(CategoryUrl);
                    response.EnsureSuccessStatusCode();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    string strData = await response.Content.ReadAsStringAsync();
                    List<Category> categories = JsonSerializer.Deserialize<List<Category>>(strData, options);
                    return View(categories);
                }
                catch
                {
                    return NoContent();
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // GET: Categories/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{CategoryUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var category = JsonSerializer.Deserialize<Category>(strData, options);

                    return View(category);
                }
                else
                {
                    return View("NotFound");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // GET: Categories/Create
        public IActionResult Create()
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        // POST: Categories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CategoryId,CategoryName")] Category category)
        {
            try
            {
                var memberJson = JsonSerializer.Serialize(category);
                var content = new StringContent(memberJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(CategoryUrl, content);
                response.EnsureSuccessStatusCode();

                var role = HttpContext.Session.GetInt32("Role");
                if (role == 1)
                {
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    return RedirectToAction("Login", "Accounts");
                }
            }
            catch
            {
                return View(category);
            }
        }

        // GET: Categories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{CategoryUrl}/{id}");
                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var category = JsonSerializer.Deserialize<Category>(strData, options);

                    return View(category);
                }
                else
                {
                    return View("NotFound");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // POST: Categories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CategoryId,CategoryName")] Category category)
        {
            try
            {
                var categoryJson = JsonSerializer.Serialize(category);
                var content = new StringContent(categoryJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PutAsync($"{CategoryUrl}/{id}", content);
                response.EnsureSuccessStatusCode();

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View(category);
            }
        }

        // GET: Categories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{CategoryUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var category = JsonSerializer.Deserialize<Category>(strData, options);

                    return View(category);
                }
                else
                {
                    return View("NotFound");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // POST: Categories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                HttpResponseMessage response = await client.DeleteAsync($"{CategoryUrl}/{id}");
                response.EnsureSuccessStatusCode();

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Index));
            }
        }
    }
}
