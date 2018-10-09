package com.sparktg.contracts;

public class Billing {

    private int id;
    private int svcId;
    private int adminRate;
    private int agentRate;
    private int smsRate;
    private int incoming;
    private int agentConnect;
    private int cug;
    private int customerConnect;
    private int oneTimeCharges;
    private int monthlyCharges;
    private int annualRecurring;
    private int freeCallingValue;
    private String adderEmail;
    private String remark;

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

    public int getAdminRate() {
        return adminRate;
    }

    public void setAdminRate(int adminRate) {
        this.adminRate = adminRate;
    }

    public int getAgentRate() {
        return agentRate;
    }

    public void setAgentRate(int agentRate) {
        this.agentRate = agentRate;
    }

    public int getIncoming() {
        return incoming;
    }

    public void setIncoming(int incoming) {
        this.incoming = incoming;
    }

    public int getAgentConnect() {
        return agentConnect;
    }

    public void setAgentConnect(int agentConnect) {
        this.agentConnect = agentConnect;
    }

    public int getCug() {
        return cug;
    }

    public void setCug(int cug) {
        this.cug = cug;
    }

    public int getCustomerConnect() {
        return customerConnect;
    }

    public void setCustomerConnect(int customerConnect) {
        this.customerConnect = customerConnect;
    }

    public int getOneTimeCharges() {
        return oneTimeCharges;
    }

    public void setOneTimeCharges(int oneTimeCharges) {
        this.oneTimeCharges = oneTimeCharges;
    }

    public int getMonthlyCharges() {
        return monthlyCharges;
    }

    public void setMonthlyCharges(int monthlyCharges) {
        this.monthlyCharges = monthlyCharges;
    }

    public int getAnnualRecurring() {
        return annualRecurring;
    }

    public void setAnnualRecurring(int annualRecurring) {
        this.annualRecurring = annualRecurring;
    }

    public int getFreeCallingValue() {
        return freeCallingValue;
    }

    public void setFreeCallValue(int freeCallingValue) {
        this.freeCallingValue = freeCallingValue;
    }

    public int getSMSRate() {
        return smsRate;
    }

    public void setSMSRate(int smsRate) {
        this.smsRate = smsRate;
    }

    public String getAdderEmail() {
        return adderEmail;
    }

    public void setAdderEmail(String adderEmail) {
        this.adderEmail = adderEmail;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
