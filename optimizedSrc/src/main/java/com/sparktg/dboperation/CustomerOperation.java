package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.Customer;

public class CustomerOperation {
	private static Logger log = LoggerFactory.getLogger(CustomerOperation.class);
	private static Connection con = null;

	public static List<Customer> getCustomer(String siteIdNamePhone) {
		List<Customer> list = new ArrayList<>();
		String query = "select site_id, name, \"userName\", \"emailId\", phone from advant.registered_users, advant.site where site_id = id order by id";
		try {
			con = ConnectionManager.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			if (siteIdNamePhone != null) {
				query = "select site_id, name, \"userName\", \"emailId\", phone from advant.registered_users as r_user left outer join advant.site as site on r_user.site_id = site.id where (site.id::varchar = ? or LOWER(site.name) like LOWER(?) or LOWER(r_user.phone) like LOWER(?)) and site.name is not null order by site.id";
				ps = con.prepareStatement(query);
				ps.setString(1, siteIdNamePhone);
				ps.setString(2, "%" + siteIdNamePhone + "%");
				ps.setString(3, "%" + siteIdNamePhone + "%");
			}
			ResultSet rs = ps.executeQuery();
			log.info(ps.toString());
			while (rs.next()) {
				Customer customer = new Customer();
				customer.setSiteId(rs.getInt("site_id"));
				customer.setSiteName(rs.getString("name"));
				customer.setUserName(rs.getString("userName"));
				customer.setEmailId(rs.getString("emailId"));
				customer.setPhone(rs.getString("phone"));
				list.add(customer);
			}
		} catch (Exception e) {
			log.error("Error while searching site_id or site_name :" + e.getMessage(), e);
		} finally {
			ConnectionManager.closeConnection();
		}
		return list;
	}

	public static int insertCustomer(Customer customer) {
		try {
			con = ConnectionManager.getConnection();
			PreparedStatement ps = con.prepareStatement("insert into advant.registered_users values(?, ?, ?, ?)");
			ps.setString(1, customer.getPhone());
			ps.setString(2, customer.getUserName());
			ps.setString(3, customer.getEmailId());
			ps.setInt(4, customer.getSiteId());
			log.info(ps.toString());
			return ps.executeUpdate();
		} catch (Exception e) {
			log.error("Error while inserting customer details :" + e);
		} finally {
			ConnectionManager.closeConnection();
		}
		return 0;
	}

	public static int updateCustomer(Customer customer) {
		try {
			con = ConnectionManager.getConnection();
			PreparedStatement ps = con.prepareStatement("update advant.registered_users set \"userName\" = ?, \"emailId\" = ? where phone = ?");
			ps.setString(1, customer.getUserName());
			ps.setString(2, customer.getEmailId());
			ps.setString(3, customer.getPhone());
			log.info(ps.toString());
			return ps.executeUpdate();
	    } catch (Exception e) {
			log.error("Error while updating customer details :" + e);
		} finally {
			ConnectionManager.closeConnection();
		}
		return 0;
	}

	public static int deleteCustomer(String phone) {
		if (phone == null) {
		    return 0;
		}
		try {
			con = ConnectionManager.getConnection();
			PreparedStatement ps = con.prepareStatement("delete from advant.registered_users where phone = ?");
			ps.setString(1, phone);
			log.info(ps.toString());
			return ps.executeUpdate();
		} catch (Exception e) {
			log.error("Error while deleting customer :" + e);
		} finally {
			ConnectionManager.closeConnection();
		}
		return 0;
	}
}