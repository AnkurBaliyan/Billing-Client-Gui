package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.Client;

public class ClientOperation {
    private static Logger log = LoggerFactory.getLogger(ClientOperation.class);
	private static Connection con= null;

    public static List<Client> search(String serviceId,int start, int total) {
        List<Client> list = new ArrayList<>();
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from client_details where svc_id::varchar=? or LOWER(service_name) like LOWER(?) or LOWER(customer_name) like LOWER(?) order by svc_id limit ? offset ?");
            ps.setString(1, serviceId);
            ps.setString(2, "%" +serviceId+"%");
            ps.setString(3, "%" +serviceId+"%");
            ps.setInt(4, total);
            ps.setInt(5, start-1);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                Client client = new Client();
                client.setId(rs.getInt("id"));
                client.setServiceId(rs.getInt("svc_id"));
                client.setServiceName(rs.getString("service_name"));
                client.setCustomerName(rs.getString("customer_name"));
                client.setGSTNumber(rs.getString("gst"));
                client.setBillingAddress1(rs.getString("billing_address_1"));
                client.setBillingAddress2(rs.getString("billing_address_2"));
                client.setBillingCity(rs.getString("billing_city"));
                client.setBillingState(rs.getString("billing_state"));
                client.setBillingPinCode(rs.getString("billing_pin_code"));
                client.setMailingAddress1(rs.getString("mailing_address_1"));
                client.setMailingAddress2(rs.getString("mailing_address_2"));
                client.setMailingCity(rs.getString("mailing_city"));
                client.setMailingState(rs.getString("mailing_state"));
                client.setMailingPinCode(rs.getString("mailing_pin_code"));
                client.setOwnerName(rs.getString("owner_name"));
                client.setOwnerEmail(rs.getString("owner_email"));
                client.setOwnerNumber(rs.getString("owner_number"));
                client.setAccountsName(rs.getString("accounts_name"));
                client.setAccountsEmail(rs.getString("accounts_email"));
                client.setAccountsNumber(rs.getString("accounts_number"));
                client.setRemark(rs.getString("remark"));
                client.setDocumentLink(rs.getString("document_link"));
                client.setInsertedDate(rs.getString("activation_date"));
                client.setEBill(rs.getBoolean("ebill"));
                client.setDeactivateDate(rs.getString("deactivation_date"));
                list.add(client);
            }
        } catch (Exception ex) {
            log.error("Error while searching svc_id :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while searching svc_id :" + ex);
            }
        }
        return list;
    }

    public static int totalNumberOfSameServiceName(String serviceName) {
        int totalrow = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps =con.prepareStatement("select count(*) from client_details  where svc_id::varchar=? or LOWER(service_name) like LOWER(?) or LOWER(customer_name) like LOWER(?) ");
            ps.setString(1, serviceName);
            ps.setString(2, "%"+serviceName+"%");
            ps.setString(3, "%"+serviceName+"%");
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            if (rs.next()) {
                totalrow = rs.getInt(1);
            }
        } catch (Exception ex) {
            log.error("Error while selecting total number of similar sevice name from client table :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while selecting total number of similar sevice name from client table :" + ex);
            }
        }
        return totalrow;
    }

    public static int insert(Client client) {
        int status = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into client_details(svc_id,service_name,customer_name,gst,owner_name,owner_email,owner_number,accounts_name,accounts_email,accounts_number,document_link,adder_email,remark,ebill,billing_address_1,billing_address_2,billing_city,billing_state,billing_pin_code,mailing_address_1,mailing_address_2,mailing_city,mailing_state,mailing_pin_code) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, client.getServiceId());
            ps.setString(2, client.getServiceName());
            ps.setString(3, client.getCustomerName());
            ps.setString(4, client.getGSTNumber());
            ps.setString(5, client.getOwnerName());
            ps.setString(6, client.getOwnerEmail());
            ps.setString(7, client.getOwnerNumber());
            ps.setString(8, client.getAccountsName());
            ps.setString(9, client.getAccountsEmail());
            ps.setString(10, client.getAccountsNumber());
            ps.setString(11, client.getDocumentLink());
            ps.setString(12, client.getAdderEmail());
            ps.setString(13, client.getRemark());
            ps.setBoolean(14, client.getEBill());
            ps.setString(15, client.getBillingAddress1());
            ps.setString(16, client.getBillingAddress2());
            ps.setString(17, client.getBillingCity());
            ps.setString(18, client.getBillingState());
            ps.setString(19, client.getBillingPinCode());
            ps.setString(20, client.getMailingAddress1());
            ps.setString(21, client.getMailingAddress2());
            ps.setString(22, client.getMailingCity());
            ps.setString(23, client.getMailingState());
            ps.setString(24, client.getMailingPinCode());
            status = ps.executeUpdate();
            log.info(ps.toString());
        } catch (Exception ex) {
            log.error("Error while inserting client details :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
                } catch (Exception ex) {
                    log.error("Error while inserting client details :" + ex);
                }
        }
        return status;
    }

    public static int totalNumberOfRecordByMonth(String fromDate,String toDate ) {
        int totalrow = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select count(*) from client_details  where activation_date between ?::date and ?::date ");
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            if (rs.next()) {
                totalrow = rs.getInt(1);
            }
        } catch (Exception ex) {
            log.error("Error while selecting total number of records from client table :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while selecting total number of record from client table :" + ex);
            }
        }
        return totalrow;
    }

    public static List<Client> retrieveClientListByMonth(String fromDate,String toDate,int start, int total) {
        List<Client> list = new ArrayList<>();
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from client_details where activation_date between ?::date and ?::date order by svc_id limit ? offset ?");
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ps.setInt(3, total);
            ps.setInt(4, start - 1);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                Client client = new Client();
                client.setId(rs.getInt("id"));
                client.setServiceId(rs.getInt("svc_id"));
                client.setServiceName(rs.getString("service_name"));
                client.setCustomerName(rs.getString("customer_name"));
                client.setGSTNumber(rs.getString("gst"));
                client.setBillingAddress1(rs.getString("billing_address_1"));
                client.setBillingAddress2(rs.getString("billing_address_2"));
                client.setBillingCity(rs.getString("billing_city"));
                client.setBillingState(rs.getString("billing_state"));
                client.setBillingPinCode(rs.getString("billing_pin_code"));
                client.setMailingAddress1(rs.getString("mailing_address_1"));
                client.setMailingAddress2(rs.getString("mailing_address_2"));
                client.setMailingCity(rs.getString("mailing_city"));
                client.setMailingState(rs.getString("mailing_state"));
                client.setMailingPinCode(rs.getString("mailing_pin_code"));
                client.setOwnerName(rs.getString("owner_name"));
                client.setOwnerEmail(rs.getString("owner_email"));
                client.setOwnerNumber(rs.getString("owner_number"));
                client.setAccountsName(rs.getString("accounts_name"));
                client.setAccountsEmail(rs.getString("accounts_email"));
                client.setAccountsNumber(rs.getString("accounts_number"));
                client.setRemark(rs.getString("remark"));
                client.setDocumentLink(rs.getString("document_link"));
                client.setInsertedDate(rs.getString("activation_date"));
                client.setDeactivateDate(rs.getString("deactivation_date"));
                client.setEBill(rs.getBoolean("ebill"));
                list.add(client);
            }
        } catch (Exception ex) {
            log.error("Error while retrieving service id list :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while retrieving service id list :" + ex);
            }
        }
        return list;
    }

    public static Client searchForUpdate(int serviceId) {
		Client client = new Client();
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from client_details where svc_id=?");
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                client.setId(rs.getInt("id"));
                client.setServiceId(rs.getInt("svc_id"));
                client.setServiceName(rs.getString("service_name"));
                client.setCustomerName(rs.getString("customer_name"));
                client.setGSTNumber(rs.getString("gst"));
                client.setOwnerName(rs.getString("owner_name"));
                client.setOwnerEmail(rs.getString("owner_email"));
                client.setOwnerNumber(rs.getString("owner_number"));
                client.setAccountsName(rs.getString("accounts_name"));
                client.setAccountsEmail(rs.getString("accounts_email"));
                client.setAccountsNumber(rs.getString("accounts_number"));
                client.setRemark(rs.getString("remark"));
                client.setDocumentLink(rs.getString("document_link"));
                client.setInsertedDate(rs.getString("activation_date"));
                client.setEBill(rs.getBoolean("ebill"));
                client.setBillingAddress1(rs.getString("billing_address_1"));
                client.setBillingAddress2(rs.getString("billing_address_2"));
                client.setBillingCity(rs.getString("billing_city"));
                client.setBillingState(rs.getString("billing_state"));
                client.setBillingPinCode(rs.getString("billing_pin_code"));
                client.setMailingAddress1(rs.getString("mailing_address_1"));
                client.setMailingAddress2(rs.getString("mailing_address_2"));
                client.setMailingCity(rs.getString("mailing_city"));
                client.setMailingState(rs.getString("mailing_state"));
                client.setMailingPinCode(rs.getString("mailing_pin_code"));
                client.setDeactivateDate(rs.getString("deactivation_date"));
            }
        } catch (Exception ex) {
            log.error("Error while searching svc_id :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while searching svc_id :" + ex);
            }
        }
        return client;
    }

    public static int updateClient(Client client) {
        int status = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("update client_details set service_name=?, customer_name=?,gst=?,owner_name=?,owner_email=?,owner_number=?,accounts_name=?,accounts_email=?,accounts_number=?,document_link=?,remark=?,ebill=?,adder_email=?,billing_address_1=?,billing_address_2=?,billing_city=?,billing_state=?,billing_pin_code=?,mailing_address_1=?,mailing_address_2=?,mailing_city=?,mailing_state=?,mailing_pin_code=?,deactivation_date=?::date where svc_id=?");
            ps.setString(1, client.getServiceName());
            ps.setString(2, client.getCustomerName());
            ps.setString(3, client.getGSTNumber());
            ps.setString(4, client.getOwnerName());
            ps.setString(5, client.getOwnerEmail());
            ps.setString(6, client.getOwnerNumber());
            ps.setString(7, client.getAccountsName());
            ps.setString(8, client.getAccountsEmail());
            ps.setString(9, client.getAccountsNumber());
            ps.setString(10, client.getDocumentLink());
            ps.setString(11, client.getRemark());
            ps.setBoolean(12, client.getEBill());
            ps.setString(13, client.getAdderEmail());
            ps.setString(14, client.getBillingAddress1());
            ps.setString(15, client.getBillingAddress2());
            ps.setString(16, client.getBillingCity());
            ps.setString(17, client.getBillingState());
            ps.setString(18, client.getBillingPinCode());
            ps.setString(19, client.getMailingAddress1());
            ps.setString(20, client.getMailingAddress2());
            ps.setString(21, client.getMailingCity());
            ps.setString(22, client.getMailingState());
            ps.setString(23, client.getMailingPinCode());
            ps.setString(24, client.getDeactivateDate());
            ps.setInt(25, client.getServiceId());
            status = ps.executeUpdate();
            log.info(ps.toString());
        } catch (Exception ex) {
            log.error("Error while updating client details : "+ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while updating client details : "+ex);
            }
        }
        return status;
    }
}
