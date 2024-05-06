using System;
using System.Collections.Generic;

namespace EyeChic_API.Models
{
    public partial class Order
    {
        public Order()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int OrderId { get; set; }
        public DateTime? OrderDate { get; set; }
        public int? TotalPrice { get; set; }
        public int? AccountId { get; set; }
        public DateTime? ShipDate { get; set; }
        public string? Status { get; set; }

        public virtual Account? Account { get; set; } = null!;
        public virtual ICollection<OrderDetail>? OrderDetails { get; set; }

    }
}
