using EyeChic_MVC.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace EyeChic_MVC.Controllers
{
    public class CartsController : Controller
    {
        private readonly HttpClient client;
        private string ProductUrl = "http://localhost:5209/api/Products";
        private string OrderUrl = "http://localhost:5209/api/Orders";
        private string OrderDetailUrl = "http://localhost:5209/api/OrderDetails";

        public CartsController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        public async Task<IActionResult> AddToCart(int? id, int? num)
        {
            if(HttpContext.Session.GetString("Email") == null)
            {
                return RedirectToAction("Login", "Accounts");
            }
            else
            {
                int? pdid = id;
                var response = await client.GetAsync($"{ProductUrl}/{id}");
                Product product;
                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };

                    product = JsonSerializer.Deserialize<Product>(strData, options);
                }
                else
                {
                    return View("NotFound");
                }

                List<Cart> cartItems;
                if (HttpContext.Session.TryGetValue("Cart", out var cartData))
                {
                    cartItems = JsonSerializer.Deserialize<List<Cart>>(cartData);
                }
                else
                {
                    cartItems = new List<Cart>();
                }

                var existingCartItem = cartItems.SingleOrDefault(item => item.Product.ProductId == pdid);
                if (existingCartItem != null)
                {
                    if (num >= existingCartItem.num)
                    {
                        existingCartItem.num += 1;
                    }
                    else
                    {
                        existingCartItem.num -= 1;
                    }
                    if (existingCartItem.num == 0)
                    {
                        cartItems.Remove(existingCartItem);
                    }
                }
                else
                {
                    var newCartItem = new Cart
                    {
                        Product = product,
                        num = 1
                    };
                    cartItems.Add(newCartItem);
                }

                // Lưu danh sách sản phẩm vào session
                var serializedCart = JsonSerializer.Serialize(cartItems);
                HttpContext.Session.Set("Cart", Encoding.UTF8.GetBytes(serializedCart));

                string refererUrl = Request.Headers["Referer"].ToString();
                return Redirect(refererUrl);
            }
            
        }

        public IActionResult Cart()
        {
            List<Cart> cartItems;
            if (HttpContext.Session.TryGetValue("Cart", out var cartData))
            {
                cartItems = JsonSerializer.Deserialize<List<Cart>>(cartData);
            }
            else
            {
                cartItems = new List<Cart>();
            }

            return View(cartItems);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateCart()
        {
            int account = HttpContext.Session.GetInt32("MemberId") ?? 0;

            List<Cart> cartItems;
            if (HttpContext.Session.TryGetValue("Cart", out var cartData))
            {
                cartItems = JsonSerializer.Deserialize<List<Cart>>(cartData);
            }
            else
            {
                cartItems = new List<Cart>();
            }

            if (cartItems.Count > 0)
            {
              


                DateTime RequiredDate = DateTime.Parse(HttpContext.Request.Form["orderDate"]);
                DateTime ShipDate = DateTime.Parse(HttpContext.Request.Form["shipDate"]);
                int totalPrice = int.Parse(HttpContext.Request.Form["totalPrice"]);

                Order order = new Order();
                order.OrderDate = RequiredDate;
                order.AccountId = account;
                order.TotalPrice = totalPrice;
                order.ShipDate = ShipDate;
                order.Status = "Processing";

                var orderJson = JsonSerializer.Serialize(order);
                var content = new StringContent(orderJson, Encoding.UTF8, "application/json");

                HttpResponseMessage responseOrder = await client.PostAsync(OrderUrl, content);
                responseOrder.EnsureSuccessStatusCode();

                string jsonResponse = await responseOrder.Content.ReadAsStringAsync();
                using (JsonDocument doc = JsonDocument.Parse(jsonResponse))
                {
                    JsonElement root = doc.RootElement;
                    int orderId = root.GetProperty("orderId").GetInt32(); // Thay thế "orderId" bằng tên thuộc tính phản hồi thực tế của bạn

                    foreach (var item in cartItems)
                    {
                        var responseProduct = await client.GetAsync($"{ProductUrl}/{item.Product.ProductId}");

                        string strData = await responseProduct.Content.ReadAsStringAsync();
                        var options = new JsonSerializerOptions
                        {
                            PropertyNameCaseInsensitive = true
                        };

                        Product product = JsonSerializer.Deserialize<Product>(strData, options);
                        if (product != null && product.Quantity >= item.num)
                        {
                            product.Quantity -= item.num;
                            var productJson = JsonSerializer.Serialize(product);
                            var productContent = new StringContent(productJson, Encoding.UTF8, "application/json");

                            HttpResponseMessage responseUpdateProduct = await client.PutAsync($"{ProductUrl}/{product.ProductId}", productContent);
                            responseUpdateProduct.EnsureSuccessStatusCode();
                            OrderDetail orderDetail = new OrderDetail
                            {
                                ProductId = item.Product.ProductId,
                                UnitPrice = item.Product.Price,
                                Quantity = item.num,
                                OrderId = orderId, // Gán orderId vào OrderDetail
                                Discount = 0
                            };

                            // Tạo đơn hàng chi tiết
                            var orderDetailJson = JsonSerializer.Serialize(orderDetail);
                            var orderDetailContent = new StringContent(orderDetailJson, Encoding.UTF8, "application/json");

                            HttpResponseMessage responseOrderDetail = await client.PostAsync(OrderDetailUrl, orderDetailContent);
                            responseOrderDetail.EnsureSuccessStatusCode();
                        }
                        else
                        {
                            return View();
                        }
                    }
                }
            }

            // Xóa giỏ hàng sau khi tạo hóa đơn thành công
            HttpContext.Session.Remove("Cart");

            TempData["SuccessMessage"] = "Đặt Hàng Thành Công. Theo Dõi Đơn Hàng Trong tab OrderManager.";
            return View("Cart");
        }
    }

    public class Cart
    {
        public Product Product { get; set; }
        public int num { get; set; }
    }
}
