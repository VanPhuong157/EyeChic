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

namespace EyeChic_MVC.Controllers
{
    public class OrdersController : Controller
    {
        private readonly HttpClient client;
        private string OrderUrl = "http://localhost:5209/api/Orders";
        private string AcountUrl = "http://localhost:5209/api/Accounts";
        private string OrderDetailsUrl = "http://localhost:5209/api/OrderDetails";
        private string ProductsUrl = "http://localhost:5209/api/Products";

        public OrdersController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        // GET: Orders
        public async Task<IActionResult> Index()
        {
            int? role = HttpContext.Session.GetInt32("Role");
            if (role == 1 || role == 0)
            {
                try
                {
                    int? accountId = HttpContext.Session.GetInt32("MemberId");

                    HttpResponseMessage ordersResponse = await client.GetAsync(OrderUrl);
                    HttpResponseMessage membersResponse = await client.GetAsync(AcountUrl);
                    HttpResponseMessage OrderDetails = await client.GetAsync(OrderDetailsUrl);
                    HttpResponseMessage Products = await client.GetAsync(ProductsUrl);

                    if (ordersResponse.IsSuccessStatusCode && membersResponse.IsSuccessStatusCode)
                    {
                        string ordersData = await ordersResponse.Content.ReadAsStringAsync();
                        string membersData = await membersResponse.Content.ReadAsStringAsync();
                        string orderDetails = await OrderDetails.Content.ReadAsStringAsync();
                        string products = await Products.Content.ReadAsStringAsync();

                        var options = new JsonSerializerOptions
                        {
                            PropertyNameCaseInsensitive = true
                        };

                        List<Order> orders = JsonSerializer.Deserialize<List<Order>>(ordersData, options);
                        List<Account> account = JsonSerializer.Deserialize<List<Account>>(membersData, options);
                        List<OrderDetail> orderDetailsList = JsonSerializer.Deserialize<List<OrderDetail>>(orderDetails, options);
                        List<Product> productsList = JsonSerializer.Deserialize<List<Product>>(products, options);
                        int? totalRevenue = orders.Sum(o => o.TotalPrice);
                        ViewData["TotalRevenue"] = totalRevenue;
                        // Find the product with the highest quantity sold
                        var bestSellerProductId = orderDetailsList
                            .GroupBy(od => od.ProductId)
                            .OrderByDescending(g => g.Sum(od => od.Quantity))
                            .FirstOrDefault()?.Key;

                        // Find the product with the lowest quantity sold
                        var lowestSellerProductId = orderDetailsList
                            .GroupBy(od => od.ProductId)
                            .OrderBy(g => g.Sum(od => od.Quantity))
                            .FirstOrDefault()?.Key;

                        // Find the product objects for the best-selling and lowest-selling products
                        var bestSellerProduct = productsList.FirstOrDefault(p => p.ProductId == bestSellerProductId);
                        var lowestSellerProduct = productsList.FirstOrDefault(p => p.ProductId == lowestSellerProductId);

                        // Pass the best-selling and lowest-selling products to the view
                        ViewData["BestProduct"] = bestSellerProduct;
                        ViewData["LowestProduct"] = lowestSellerProduct;

                        foreach (var order in orders)
                        {
                            order.Account = account.FirstOrDefault(m => m.AccountId == order.AccountId);
                        }

                        if (role == 1)
                        {
                            return View(orders);
                        }
                        return View(orders.Where(o => o.AccountId == accountId));
                    }
                    return NoContent();
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



        // GET: Orders/Details/5
        public async Task<IActionResult> Details(int? id)
        {





            return View();
        }

        // GET: Orders/Create
        public IActionResult Create()
        {

            return View();
        }

        // POST: Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("OrderId,OrderDate,TotalPrice,AccountId,ShipDate,Status")] Order order)
        {

            return View();
        }

        // GET: Orders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {

            return View();
        }

        // POST: Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderId,OrderDate,TotalPrice,AccountId,ShipDate,Status")] Order order)
        {

            return View();
        }

        // GET: Orders/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {

            return View();
        }


    }
}
