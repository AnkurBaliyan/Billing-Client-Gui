package com.sparktg.contracts;

public class Client {

	private int id;
	private int svcId;
	private String serviceName;
	private String customerName;
	private String GSTNumber;
	private String billingAddress1;
	private String billingAddress2;
	private String billingCity;
	private String billingState;
	private String billingPinCode;
	private String mailingAddress1;
	private String mailingAddress2;
	private String mailingCity;
	private String mailingState;
	private String mailingPinCode;
	private String ownerName;
	private String ownerEmail;
	private String ownerNumber;
	private String accountsName;
	private String accountsEmail;
	private String accountsNumber;
	private String adderEmail;
	private String documentLink;
	private String remark;
	private String insertedDate;
	private String deactivateDate;
	private boolean eBill;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getServiceId() {
		return svcId;
	}

	public void setServiceId(int svcId) {
		this.svcId = svcId;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getGSTNumber() {
		return GSTNumber;
	}

	public void setGSTNumber(String GSTNumber) {
		this.GSTNumber = GSTNumber;
	}

    public String getBillingAddress1() {
        return billingAddress1;
    }

    public void setBillingAddress1(String billingAddress1) {
        this.billingAddress1 = billingAddress1;
    }

    public String getBillingAddress2() {
        return billingAddress2;
    }

    public void setBillingAddress2(String billingAddress2) {
        this.billingAddress2 = billingAddress2;
    }

    public String getBillingCity() {
        return billingCity;
    }

    public void setBillingCity(String billingCity) {
        this.billingCity = billingCity;
    }

    public String getBillingState() {
        return billingState;
    }

    public void setBillingState(String billingState) {
        this.billingState = billingState;
    }

    public String getBillingPinCode() {
        return billingPinCode;
    }

    public void setBillingPinCode(String billingPinCode) {
        this.billingPinCode = billingPinCode;
    }

    public String getMailingAddress1() {
        return mailingAddress1;
    }

    public void setMailingAddress1(String mailingAddress1) {
        this.mailingAddress1 = mailingAddress1;
    }

    public String getMailingAddress2() {
        return mailingAddress2;
    }

    public void setMailingAddress2(String mailingAddress2) {
        this.mailingAddress2 = mailingAddress2;
    }

    public String getMailingCity() {
        return mailingCity;
    }

    public void setMailingCity(String mailingCity) {
        this.mailingCity = mailingCity;
    }

    public String getMailingState() {
        return mailingState;
    }

    public void setMailingState(String mailingState) {
        this.mailingState = mailingState;
    }

    public String getMailingPinCode() {
        return mailingPinCode;
    }

    public void setMailingPinCode(String mailingPinCode) {
        this.mailingPinCode = mailingPinCode;
    }

    public String getOwnerName() {
		return ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	public String getOwnerNumber() {
		return ownerNumber;
	}

	public void setOwnerNumber(String ownerNumber) {
		this.ownerNumber = ownerNumber;
	}

	public String getOwnerEmail() {
		return ownerEmail;
	}

	public void setOwnerEmail(String ownerEmail) {
		this.ownerEmail = ownerEmail;
	}

	public String getAccountsName() {
		return accountsName;
	}

	public void setAccountsName(String accountsName) {
		this.accountsName = accountsName;
	}

	public String getAccountsEmail() {
		return accountsEmail;
	}

	public void setAccountsEmail(String accountsEmail) {
		this.accountsEmail = accountsEmail;
	}

	public String getAccountsNumber() {
		return accountsNumber;
	}

	public void setAccountsNumber(String accountsNumber) {
		this.accountsNumber = accountsNumber;
	}

	public String getAdderEmail() {
		return adderEmail;
	}

	public void setAdderEmail(String adderEmail) {
		this.adderEmail = adderEmail;
	}

	public String getDocumentLink() {
		return documentLink;
	}

	public void setDocumentLink(String documentLink) {
		this.documentLink = documentLink;
	}

	public String getInsertedDate() {
		return insertedDate;
	}

	public void setInsertedDate(String insertedDate) {
		this.insertedDate = insertedDate;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

    public String getDeactivateDate() {
        return deactivateDate;
    }

    public void setDeactivateDate(String deactivateDate){
        this.deactivateDate = deactivateDate;
    }

	public boolean getEBill() {
		return eBill;
	}

	public void setEBill(boolean eBill) {
		this.eBill= eBill;
	}
}