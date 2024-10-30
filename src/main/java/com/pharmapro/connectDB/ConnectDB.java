package com.pharmapro.connectDB;

import java.sql.*;

public class ConnectDB {

	
	public static Connection  dbCon(){
		
		Connection con=null;
		
		try{
			
			if(con==null){
				//load the Driver
				Class.forName("com.mysql.jdbc.Driver");
				//Eshtabilish the connection
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmapro","root","");
				
				
				System.out.println("Connection Estabilished!!"+con);
				
			}
			
			
		}
		catch(Exception e){
			
			e.printStackTrace();
			
		}
		
		return con;
	}
	
	
	
	
	
}
