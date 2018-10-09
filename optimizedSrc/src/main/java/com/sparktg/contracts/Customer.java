package com.sparktg.contracts;

public class Customer {
	private int siteId;
    private String siteName;
    private String userName;
    private String emailId;
    private String phone;

    public int getSiteId() {
       return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }
    
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }
}
