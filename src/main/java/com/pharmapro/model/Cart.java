package com.pharmapro.model;

public class Cart {
	
	
		
		private String user_id	;
		 private String medicine_id	;	
         private int quantity	;	
         
         
         
         public Cart(String user_id, String medicine_id, int quantity) {
     		super();
     		this.user_id = user_id;
     		this.medicine_id = medicine_id;
     		this.quantity = quantity;
     	}
         
	    

		public Cart() {
			super();
			// TODO Auto-generated constructor stub
		}



		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
		public String getMedicine_id() {
			return medicine_id;
		}
		public void setMedicine_id(String medicine_id) {
			this.medicine_id = medicine_id;
		}
		@Override
		public String toString() {
			return "Cart [user_email=" + user_id + ", medicine_id=" + medicine_id + ", quantity=" + quantity + "]";
		}



		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		
	
	

}
