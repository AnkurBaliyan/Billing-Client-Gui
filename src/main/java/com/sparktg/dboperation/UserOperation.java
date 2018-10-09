package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.User;

public class UserOperation {
	private static Logger log = LoggerFactory.getLogger(UserOperation.class);
	private static Connection con = null;

	public static int userInfo(User user) {
        int status = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into user_registration(name,email,password) values (?,?,md5(?))");
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            status = ps.executeUpdate();
            log.info(ps.toString());
        } catch (Exception ex) {
            log.error("Error while inserting user information :" + ex);
        } finally {
            try {
                if (con!= null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while inserting user information :" + ex);
            }
        }
        return status;
	}

    public static User userLogin(String email, String password) {
        User user = new User();
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from user_registration where email=? and password=md5(?)");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception ex) {
            log.error("Error while user login :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while user login :" + ex);
            }
        }
        return user;
    }

    public static User getUser(String email) {
        User user = new User();
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("select email from user_registration where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                user.setEmail(rs.getString("email"));
            }
        } catch (Exception ex) {
            log.error("Error while getting user email :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while getting user email:" + ex);
            }
        }
        return user;
    }

    public static int resetPassword(User user) {
        int status = 0;
        try {
            con=ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("update user_registration set password=md5(?) where email=?");
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getEmail());
            status = ps.executeUpdate();
        } catch (Exception ex) {
            log.error("Error while getting user email :" + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ex) {
                log.error("Error while getting user email:" + ex);
            }
        }
        return status;
    }
}
