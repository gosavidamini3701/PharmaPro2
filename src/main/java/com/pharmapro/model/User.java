package com.pharmapro.model;

public class User {
    @Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", email=" + email + ", password=" + password
				+ ", confirmPassword=" + confirmPassword + ", phone=" + phone + ", role=" + role + "]";
	}

	private int userId;
    private String userName;
    private String email;
    private String password;
    private String confirmPassword;
    private String phone;
    
	private String role;
	
    public User() {}

    public User(String userName, String email, String password, String confirmPassword, String phone,String role) {
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.phone = phone;
        this.role = role;
    }

    // Getters and Setters

    public User(int userId, String userName, String email) {
    	this.userName = userName;
        this.email = email;
        this.userId=userId;
	}

	public int getUserId() {
    	System.out.print(userId);   
    	return userId;
    }

    public void setUserId(int userId) {
    	System.out.println(userId);
        this.userId = userId;
    }

    public String getUserName() {
    	System.out.print(userName);  
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
    	System.out.print(email);  
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}


	
}
