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
using Newtonsoft.Json;
using System.Text;

namespace EyeChic_MVC.Controllers
{
    public class ProductsController : Controller
    {
        private readonly HttpClient client;
        private string ProductUrl = "http://localhost:5209/api/Products";
        private string CategoryUrl = "http://localhost:5209/api/Categories";

        public ProductsController()
        {
            client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            client.DefaultRequestHeaders.Accept.Add(contentType);
        }

        // GET: Products
           public async Task<IActionResult> Index(int? categoryId, string searchTerm)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                try
                {
                    HttpResponseMessage cate = await client.GetAsync(CategoryUrl);
                    cate.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công
                    string categoryData = await cate.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    List<Category> categories = System.Text.Json.JsonSerializer.Deserialize<List<Category>>(categoryData, options);
                    ViewBag.Categories = categories;
                    List<Product> products;
                    if (categoryId.HasValue)
                    {
                        HttpResponseMessage response1 = await client.GetAsync($"{ProductUrl}?categoryId={categoryId.Value}");
                        response1.EnsureSuccessStatusCode();
                        string strData1 = await response1.Content.ReadAsStringAsync();
                        products = System.Text.Json.JsonSerializer.Deserialize<List<Product>>(strData1, options);
                    }
                    else
                    {
                        HttpResponseMessage response = await client.GetAsync(ProductUrl);
                        response.EnsureSuccessStatusCode();

                        string strData = await response.Content.ReadAsStringAsync();
                        products = System.Text.Json.JsonSerializer.Deserialize<List<Product>>(strData, options);
                    }

                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        products = products.Where(p => p.ProductName.ToUpper().Contains(searchTerm.ToUpper())).ToList();
                    }


                    foreach (var product in products)
                    {
                        HttpResponseMessage categoryResponse = await client.GetAsync($"{CategoryUrl}/{product.CategoryId}");
                        if (categoryResponse.IsSuccessStatusCode)
                        {
                            string categoryStrData = await categoryResponse.Content.ReadAsStringAsync();
                            Category category = System.Text.Json.JsonSerializer.Deserialize<Category>(categoryStrData, options);

                            // Kiểm tra nếu product.Category là null thì tạo mới một đối tượng Category
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
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // GET: Products/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                var response = await client.GetAsync($"{ProductUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };

                    var product = System.Text.Json.JsonSerializer.Deserialize<Product>(strData, options);
                    HttpResponseMessage categoryResponse = await client.GetAsync($"{CategoryUrl}/{product.CategoryId}");
                    if (categoryResponse.IsSuccessStatusCode)
                    {
                        string categoryStrData = await categoryResponse.Content.ReadAsStringAsync();
                        Category category = System.Text.Json.JsonSerializer.Deserialize<Category>(categoryStrData, options);
                        product.Category = category; // Gán Category vào Product
                    }
                    return View(product);
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

        // GET: Products/Create
        public async Task<IActionResult> Create()
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                try
                {
                    // Gửi một yêu cầu GET để lấy danh sách các danh mục
                    HttpResponseMessage response = await client.GetAsync(CategoryUrl);
                    response.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công

                    // Đọc nội dung của phản hồi và deserialize nó thành danh sách các danh mục
                    string strData = await response.Content.ReadAsStringAsync();
                    var options = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    List<Category> categories = System.Text.Json.JsonSerializer.Deserialize<List<Category>>(strData, options);

                    // Gán danh sách các danh mục cho ViewBag
                    ViewBag.Categories = categories;

                    return View();
                }
                catch
                {
                    // Xử lý nếu có lỗi xảy ra khi lấy danh sách các danh mục
                    ViewBag.Categories = new List<Category>(); // Gán danh sách rỗng cho ViewBag
                    return View();
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // POST: Products/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ProductId,ProductName,Description,Price,Quantity,Color,Origin,Material,CategoryId,Img")] Product product)
        {
            try
            {
                var productJson = System.Text.Json.JsonSerializer.Serialize(product);
                var content = new StringContent(productJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(ProductUrl, content);
                response.EnsureSuccessStatusCode();

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View(product);
            }
        }

        // GET: Products/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                try
                {
                    // Gửi yêu cầu GET để lấy thông tin về sản phẩm cần chỉnh sửa
                    HttpResponseMessage productResponse = await client.GetAsync($"{ProductUrl}/{id}");
                    productResponse.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công

                    // Đọc nội dung của phản hồi và deserialize nó thành đối tượng Product
                    string productData = await productResponse.Content.ReadAsStringAsync();
                    var productOptions = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    Product product = System.Text.Json.JsonSerializer.Deserialize<Product>(productData, productOptions);

                    // Gửi yêu cầu GET để lấy danh sách các danh mục
                    HttpResponseMessage categoryResponse = await client.GetAsync(CategoryUrl);
                    categoryResponse.EnsureSuccessStatusCode(); // Đảm bảo yêu cầu thành công

                    // Đọc nội dung của phản hồi và deserialize nó thành danh sách các danh mục
                    string categoryData = await categoryResponse.Content.ReadAsStringAsync();
                    var categoryOptions = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    List<Category> categories = System.Text.Json.JsonSerializer.Deserialize<List<Category>>(categoryData, categoryOptions);

                    // Gán danh sách các danh mục cho ViewBag
                    ViewBag.Categories = categories;

                    // Nếu sản phẩm không tồn tại, trả về NotFound
                    if (product == null)
                    {
                        return NotFound();
                    }

                    return View(product);
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

        // POST: Products/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ProductId,ProductName,Description,Price,Quantity,Color,Origin,Material,CategoryId,Img")] Product product)
        {
            try
            {
                var memberJson = System.Text.Json.JsonSerializer.Serialize(product);
                var content = new StringContent(memberJson, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PutAsync($"{ProductUrl}/{id}", content);
                response.EnsureSuccessStatusCode();

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View(product);
            }
        }

        // GET: Products/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if(HttpContext.Session.GetInt32("Role") == 1)
            {
                if (id == null)
                {
                    return NotFound();
                }

                HttpResponseMessage productResponse = await client.GetAsync($"{ProductUrl}/{id}");
                if (!productResponse.IsSuccessStatusCode)
                {
                    return NotFound();
                }

                string productStrData = await productResponse.Content.ReadAsStringAsync();
                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                };

                var product = System.Text.Json.JsonSerializer.Deserialize<Product>(productStrData, options);

                if (product == null)
                {
                    return NotFound();
                }

                // Lấy thông tin của Category
                HttpResponseMessage categoryResponse = await client.GetAsync($"{CategoryUrl}/{product.CategoryId}");
                if (categoryResponse.IsSuccessStatusCode)
                {
                    string categoryStrData = await categoryResponse.Content.ReadAsStringAsync();
                    Category category = System.Text.Json.JsonSerializer.Deserialize<Category>(categoryStrData, options);
                    product.Category = category; // Gán Category vào Product
                }

                return View(product);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }

        // POST: Products/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                // Gửi yêu cầu xóa sản phẩm đến server
                HttpResponseMessage response = await client.DeleteAsync($"{ProductUrl}/{id}");

                if (response.IsSuccessStatusCode)
                {
                    // Nếu xóa thành công, chuyển hướng đến trang danh sách sản phẩm
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    // Xử lý lỗi nếu không thể xóa sản phẩm
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
