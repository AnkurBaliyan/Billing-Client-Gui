package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.Technician;

public class TechnicianOperation {
    private static Logger log = LoggerFactory.getLogger(TechnicianOperation.class);
	private static Connection con = null;

    public static List<Technician> getTechnician(String technicianIdName, Integer id) {
        List<Technician> list = new ArrayList<>();
        String query= "select * from advant.technicians order by technician_id";
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            if (technicianIdName != null) {
				query = "select * from advant.technicians where technician_id::varchar = ? or LOWER(technician_name) like LOWER(?) order by technician_id";
				ps = con.prepareStatement(query);
				ps.setString(1, technicianIdName);
				ps.setString(2, "%" + technicianIdName + "%");
			}
            if (id != null) {
				query = "select * from advant.technicians where id = ?";
				ps = con.prepareStatement(query);
				ps.setInt(1, id);
			}
            ResultSet rs = ps.executeQuery();
            log.info(ps.toString());
            while (rs.next()) {
                Technician technician = new Technician();
                technician.setId(rs.getInt("id"));
                technician.setTechnicianId(rs.getInt("technician_id"));
                technician.setTechnicianName(rs.getString("technician_name"));
                technician.setTechnicianNumber(rs.getString("technician_number"));
                list.add(technician);
            }
        } catch (Exception e) {
            log.error("Error while searching technician_id or technician :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return list;
    }

    public static int insertTechnician(Technician technician) {
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into advant.technicians (technician_id,technician_name,technician_number) values (?,?,?)");
            ps.setInt(1, technician.getTechnicianId());
            ps.setString(2, technician.getTechnicianName());
            ps.setString(3, technician.getTechnicianNumber());
            log.info(ps.toString());
            return ps.executeUpdate();
        } catch (Exception e) {
            log.error("Error while inserting technician details :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return 0;
    }

    public static int updateTechnician(Technician technician) {
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("update advant.technicians set technician_id = ?, technician_name = ?, technician_number = ? where id = ?");
            ps.setInt(1, technician.getTechnicianId());
            ps.setString(2, technician.getTechnicianName());
            ps.setString(3, technician.getTechnicianNumber());
            ps.setInt(4, technician.getId());
            log.info(ps.toString());
            return ps.executeUpdate();
        } catch (Exception e) {
            log.error("Error while updating technician details :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return 0;
    }

    public static int deleteTechnician(int technicianId) {
        if (technicianId == 0) {
		    return 0;
		}
    	try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("delete from advant.technicians where technician_id = ?");
            ps.setInt(1, technicianId);
            log.info(ps.toString());
            return ps.executeUpdate();
        } catch (Exception e) {
            log.error("Error while deleting technician :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return 0;
    }
}