using System;
using System.Collections.Generic;

namespace EyeChic_API.Models
{
    public partial class Product
    {
        public Product()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int ProductId { get; set; }
        public string? ProductName { get; set; }
        public string? Description { get; set; }
        public int? Price { get; set; }
        public string? Color { get; set; }
        public string? Origin { get; set; }
        public string? Material { get; set; }
        public int? CategoryId { get; set; }
        public string? Img { get; set; }
        public int? Quantity { get; set; }

        public virtual Category? Category { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
