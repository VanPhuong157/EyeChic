namespace EyeChic_MVC.Models
{
    public partial class OrderDetailsDTO
    {
        public int OrderDetailId { get; set; }
        public int? Quantity { get; set; }
        public int? UnitPrice { get; set; }
        public int? Discount { get; set; }
        public int? OrderId { get; set; }
        public string? Img { get; set; }
        public virtual Product? Product { get; set; }
    }
}
