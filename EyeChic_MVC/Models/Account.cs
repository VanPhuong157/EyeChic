﻿using System;
using System.Collections.Generic;

namespace EyeChic_MVC.Models
{
    public partial class Account
    {
        public Account()
        {
            Orders = new HashSet<Order>();
        }

        public int AccountId { get; set; }
        public string? Email { get; set; }
        public string? Fullname { get; set; }
        public string? Password { get; set; }
        public int? Role { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
    }
}
