namespace EyeChic_API.Models
{
    public class OrderDTO
    {
        public DateTime? OrderDate { get; set; }
        public int? TotalPrice { get; set; }
        public int? AccountId { get; set; }
        public DateTime? ShipDate { get; set; }
        public string Status { get; set; }
    }
}
