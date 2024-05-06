using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EyeChic_MVC.Models;
using System.Net.Http.Headers;
using System.Diagnostics.Metrics;
using System.Text.Json;
using System.Text;

namespace EyeChic_MVC.Controllers
{
    public class AccountsController : Controller
    {
        private readonly HttpClient client;
        private string AccountUrl = "http://localhost:5209/api/Accounts";

        public AccountsController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        // GET: Accounts
        public async Task<IActionResult> Index()
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                try
                {
                    HttpResponseMessage response = await client.GetAsync(AccountUrl);
                    response.EnsureSuccessStatusCode();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    string strData = await response.Content.ReadAsStringAsync();
                    List<Account> members = JsonSerializer.Deserialize<List<Account>>(strData, options);
                    return View(members);
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

        [HttpPost]
        public async Task<IActionResult> Login(string Email, string Password)
        {
            try
            {
                HttpResponseMessage response = await client.GetAsync(AccountUrl);
                response.EnsureSuccessStatusCode();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };
                string strData = await response.Content.ReadAsStringAsync();
                List<Account> members = JsonSerializer.Deserialize<List<Account>>(strData, options);

                // Check if the user is an admin
                Account admin = members.FirstOrDefault(m => m.Role == 1 && m.Email == Email && m.Password == Password);
                if (admin != null)
                {
                    HttpContext.Session.SetInt32("Role", 1);
                    HttpContext.Session.SetString("Email", Email);
                    HttpContext.Session.SetInt32("MemberId", admin.AccountId);

                    return RedirectToAction("Index", "Home");
                }

                // Check if the user is a regular member
                Account user = members.FirstOrDefault(m => m.Email == Email && m.Password == Password);
                if (user != null)
                {
                    HttpContext.Session.SetInt32("Role", 0);
                    HttpContext.Session.SetString("Email", Email);
                    HttpContext.Session.SetInt32("MemberId", user.AccountId);
                    return RedirectToAction("Index", "Home");
                }

                // If user is neither admin nor regular member, return to login view
                return View();
            }
            catch
            {
                return View();
            }
        }

        [HttpGet]
        public async Task<IActionResult> Login()
        {
            return View();
        }
        public IActionResult Logout()
        {
            // Clear session variables
            HttpContext.Session.Clear();

            // Redirect to the home page or any other page after logout
            return RedirectToAction("Index", "Home");
        }


        // GET: Accounts/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{AccountUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var member = JsonSerializer.Deserialize<Account>(strData, options);

                    return View(member);
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

        // GET: Accounts/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Accounts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AccountId,Email,Fullname,Password,Role")] Account account)
        {
            try
            {
                var memberJson = JsonSerializer.Serialize(account);
                var content = new StringContent(memberJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(AccountUrl, content);
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
                return View(account);
            }
        }

        // GET: Accounts/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{AccountUrl}/{id}");
                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var member = JsonSerializer.Deserialize<Account>(strData, options);

                    return View(member);
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

        // POST: Accounts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("AccountId,Email,Fullname,Password,Role")] Account account)
        {
            try
            {
                var memberJson = JsonSerializer.Serialize(account);
                var content = new StringContent(memberJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PutAsync($"{AccountUrl}/{id}", content);
                response.EnsureSuccessStatusCode();

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View(account);
            }
        }

        // GET: Accounts/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{AccountUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var member = JsonSerializer.Deserialize<Account>(strData, options);

                    return View(member);
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

        // POST: Accounts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                HttpResponseMessage response = await client.DeleteAsync($"{AccountUrl}/{id}");
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
