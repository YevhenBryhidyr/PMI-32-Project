//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ChatServer
{
    using System;
    using System.Collections.Generic;
    
    public partial class Messages
    {
        public int Id { get; set; }
        public int Id_user_to { get; set; }
        public int Id_user_from { get; set; }
        public Nullable<System.DateTime> Created_at { get; set; }
        public string Message1 { get; set; }
    
        public virtual Users Users { get; set; }
        public virtual Users Users1 { get; set; }
    }
}
