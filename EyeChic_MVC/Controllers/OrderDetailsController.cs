using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EyeChic_MVC.Models;
using System.Text.Json;
using System.Net.Http.Headers;
using Microsoft.Extensions.Options;
using System.Text;

namespace EyeChic_MVC.Controllers
{
    public class OrderDetailsController : Controller
    {
        private readonly HttpClient client;
        private string OrderDetailsUrl = "http://localhost:5209/api/OrderDetails";
        private string OrdersUrl = "http://localhost:5209/api/Orders";
        private string ProductUrl = "http://localhost:5209/api/Products";


        public OrderDetailsController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }


        // GET: OrderDetails
        public async Task<IActionResult> Index(int id)
        {
            if (HttpContext.Session.GetInt32("Role") == 1 || HttpContext.Session.GetInt32("Role") == 0)
            {
                HttpResponseMessage OrderDetailsresponse = await client.GetAsync(OrderDetailsUrl);
                HttpResponseMessage Productresponse = await client.GetAsync(ProductUrl);

                OrderDetailsresponse.EnsureSuccessStatusCode();
                Productresponse.EnsureSuccessStatusCode();
                string OrderDetailsData = await OrderDetailsresponse.Content.ReadAsStringAsync();
                string ProductData = await Productresponse.Content.ReadAsStringAsync();
                var option = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true,
                };
                IEnumerable<OrderDetail> orderDetail = System.Text.Json.JsonSerializer.Deserialize<IEnumerable<OrderDetail>>(OrderDetailsData, option);
                IEnumerable<Product> products = System.Text.Json.JsonSerializer.Deserialize<IEnumerable<Product>>(ProductData, option);

                // Lọc chi tiết đơn hàng theo OrderId được chuyển từ liên kết
                var orderDetailsForOrderId = orderDetail.Where(od => od.OrderId == id);

                var joinedData = from od in orderDetailsForOrderId
                                 join p in products on od.ProductId equals p.ProductId
                                 select new OrderDetailsDTO
                                 {
                                     OrderDetailId = od.OrderDetailId,
                                     Quantity = od.Quantity,
                                     UnitPrice = od.UnitPrice,
                                     Discount = od.Discount,
                                     OrderId = od.OrderId,
                                     Img = p.Img
                                 };

                return View(joinedData);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }




        // GET: OrderDetails/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                try
                {
                    // Gửi yêu cầu GET để lấy thông tin về sản phẩm cần chỉnh sửa
                    HttpResponseMessage orderDetailsResponse = await client.GetAsync($"{OrderDetailsUrl}/{id}");
                    orderDetailsResponse.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công

                    // Đọc nội dung của phản hồi và deserialize nó thành đối tượng Product
                    string orderDetailsData = await orderDetailsResponse.Content.ReadAsStringAsync();
                    var orderDetailsOptions = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    OrderDetail orderDetail = JsonSerializer.Deserialize<OrderDetail>(orderDetailsData, orderDetailsOptions);

                    // Gửi yêu cầu GET để lấy danh sách các danh mục
                    HttpResponseMessage productResponse = await client.GetAsync(ProductUrl);
                    productResponse.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công

                    // Đọc nội dung của phản hồi và deserialize nó thành danh sách các danh mục
                    string productsData = await productResponse.Content.ReadAsStringAsync();
                    var productsOptions = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    List<Product> product = JsonSerializer.Deserialize<List<Product>>(productsData, productsOptions);

                    // Gán danh sách các danh mục cho ViewBag
                    ViewBag.Products = new SelectList(product, "ProductId", "ProductName", orderDetail.ProductId);

                    // Nếu sản phẩm không tồn tại, trả về NotFound
                    if (orderDetail == null)
                    {
                        return NotFound();
                    }

                    return View(orderDetail);
                }
                catch
                {
                    return NotFound(); // Xử lý lỗi nếu có
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        // POST: OrderDetails/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderDetailId,Quantity,UnitPrice,Discount,OrderId,ProductId")] OrderDetail orderDetail)
        {
            try
            {
                var memberJson = JsonSerializer.Serialize(orderDetail);
                var content = new StringContent(memberJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PutAsync($"{OrderDetailsUrl}/{id}", content);
                response.EnsureSuccessStatusCode();

                return RedirectToAction("Index", new { id = orderDetail.OrderId });
            }
            catch
            {
                return View(orderDetail);
            }
        }


        // GET: OrderDetails/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (HttpContext.Session.GetInt32("Role") == 1)
            {

                if (id == null)
                {
                    return NotFound();
                }

                HttpResponseMessage orderDetailsResponse = await client.GetAsync($"{OrderDetailsUrl}/{id}");


                string orderDetailsStrData = await orderDetailsResponse.Content.ReadAsStringAsync();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var orderdt = System.Text.Json.JsonSerializer.Deserialize<OrderDetail>(orderDetailsStrData, options);

                if (orderdt == null)
                {
                    return NotFound();
                }

                // Lấy thông tin của Products
                HttpResponseMessage productsResponse = await client.GetAsync($"{ProductUrl}/{orderdt.ProductId}");
                if (productsResponse.IsSuccessStatusCode)
                {
                    string productsStrData = await productsResponse.Content.ReadAsStringAsync();
                    Product product = System.Text.Json.JsonSerializer.Deserialize<Product>(productsStrData, options);
                    orderdt.Product = product; // Gán Category vào Product
                }
                // Lấy thông tin của Order
                HttpResponseMessage orderResponse = await client.GetAsync($"{OrdersUrl}/{orderdt.OrderId}");
                if (orderResponse.IsSuccessStatusCode)
                {
                    string ordersStrData = await orderResponse.Content.ReadAsStringAsync();
                    Order order = System.Text.Json.JsonSerializer.Deserialize<Order>(ordersStrData, options);
                    orderdt.Order = order; // Gán order vào Product
                }

                return View(orderdt);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        // POST: OrderDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                // Gửi yêu cầu xóa chi tiết đơn hàng đến server
                HttpResponseMessage response = await client.DeleteAsync($"{OrderDetailsUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    // Nếu xóa thành công, chuyển hướng đến trang danh sách OrderDetails
                    return RedirectToAction("Index", "Orders");
                }
                else
                {
                    // Xử lý lỗi nếu không thể xóa
                    return View("Error");
                }
            }
            catch (Exception ex)
            {
                // Xử lý exception nếu có
                // Ví dụ: log lại exception
                return View("Error");
            }
        }

    }
}

