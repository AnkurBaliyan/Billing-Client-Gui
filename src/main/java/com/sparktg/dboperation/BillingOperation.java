package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.Billing;

public class BillingOperation {
	private static Logger log = LoggerFactory.getLogger(BillingOperation.class);
	private static Connection con = null;

	public static int insert(Billing billing) {
        int status = 0;
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into rates(svc_id,admin_rate,agent_rate,sms_rate,incoming,agent_connect,cug,customer_connect,one_time_charges,monthly_charges,annual_recurring,free_calling_value,adder_email,remark) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, billing.getServiceId());
            ps.setFloat(2, billing.getAdminRate());
            ps.setFloat(3, billing.getAgentRate());
            ps.setFloat(4, 20);
            ps.setFloat(5, billing.getIncoming());
            ps.setFloat(6, billing.getAgentConnect());
            ps.setFloat(7, 10);
            ps.setFloat(8, billing.getCustomerConnect());
            ps.setFloat(9, billing.getOneTimeCharges());
            ps.setFloat(10, billing.getMonthlyCharges());
            ps.setFloat(11,billing.getAnnualRecurring());
            ps.setFloat(12, billing.getFreeCallingValue());
            ps.setString(13, billing.getAdderEmail());
            ps.setString(14, billing.getRemark());
            status = ps.executeUpdate();
            log.info(ps.toString());
        } catch (Exception ex) {
                log.error("Error while inserting bill details :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while inserting bill details :" + ex);
            }
        }
        return status;
    }

	public static Billing search(int serviceId) {
		Billing billing = new Billing();
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from rates where svc_id=?");
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                billing.setId(rs.getInt("id"));
                billing.setServiceId(rs.getInt("svc_id"));
                billing.setAdminRate(rs.getInt("admin_rate"));
                billing.setAgentRate(rs.getInt("agent_rate"));
                billing.setSMSRate(rs.getInt("sms_rate"));
                billing.setIncoming(rs.getInt("incoming"));
                billing.setAgentConnect(rs.getInt("agent_connect"));
                billing.setCug(rs.getInt("cug"));
                billing.setCustomerConnect(rs.getInt("customer_connect"));
                billing.setOneTimeCharges(rs.getInt("one_time_charges"));
                billing.setMonthlyCharges(rs.getInt("monthly_charges"));
                billing.setAnnualRecurring(rs.getInt("annual_recurring"));
                billing.setFreeCallValue(rs.getInt("free_calling_value"));
                billing.setRemark(rs.getString("remark"));
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
        return billing;
    }

    public static int updateBill(Billing billing) {
        int status = 0;
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("update rates set admin_rate=?,agent_rate=?,incoming=?,agent_connect=?,customer_connect=?,one_time_charges=?,monthly_charges=?,annual_recurring=?,free_calling_value=?,adder_email=?,remark=? where svc_id=?");
            ps.setFloat(1, billing.getAdminRate());
            ps.setFloat(2, billing.getAgentRate());
            ps.setFloat(3, billing.getIncoming());
            ps.setFloat(4, billing.getAgentConnect());
            ps.setFloat(5, billing.getCustomerConnect());
            ps.setFloat(6, billing.getOneTimeCharges());
            ps.setFloat(7, billing.getMonthlyCharges());
            ps.setFloat(8,billing.getAnnualRecurring());
            ps.setFloat(9, billing.getFreeCallingValue());
            ps.setString(10, billing.getAdderEmail());
            ps.setString(11, billing.getRemark());
            ps.setInt(12, billing.getServiceId());

			status = ps.executeUpdate();
			log.info(ps.toString());
        } catch (Exception ex) {
            log.error("Error while updating bill details : "+ex);
        } finally {
            try {
				if (con != null) {
				    con.close();
				}
			} catch (Exception ex) {
				log.error("Error while updating bill details : "+ex);
			}
		}

		return status;
	}
}
