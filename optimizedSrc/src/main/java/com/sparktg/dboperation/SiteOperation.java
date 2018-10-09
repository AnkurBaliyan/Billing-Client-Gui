package com.sparktg.dboperation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sparktg.contracts.Site;

public class SiteOperation {
	private static Logger log = LoggerFactory.getLogger(SiteOperation.class);
	private static Connection con = null;

	public static List<Site> getSite(String siteIdName,Integer siteId, String idOrName) {
		List<Site> list = new ArrayList<>();
		String query = "select * from advant.site order by "+ idOrName ;
		try {
			con = ConnectionManager.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			if (siteIdName != null) {
				query = "select * from advant.site where id::varchar = ? or LOWER(name) like LOWER(?)";
				ps = con.prepareStatement(query);
				ps.setString(1, siteIdName);
				ps.setString(2, "%" + siteIdName + "%");
			}
			if (siteId != null) {
				query = "select * from advant.site where id = ?";
				ps = con.prepareStatement(query);
				ps.setInt(1, siteId);
			}
			ResultSet rs = ps.executeQuery();
			log.info(ps.toString());
			while (rs.next()) {
				Site site = new Site();
				site.setSiteId(rs.getInt("id"));
				site.setSiteName(rs.getString("name"));
				list.add(site);
			}
		} catch (Exception e) {
			log.error("Error while searching site list :" + e);
		} finally {
            ConnectionManager.closeConnection();
		}
		return list;
	}

	public static int insertSite(Site site) {
		try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into advant.site(name) values(?) returning id");
            ps.setString(1, site.getSiteName());
            log.info(ps.toString());
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            log.error("Error while inserting site name :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return 0;
    }

    public static int updateSiteName(Site site) {
        try {
            con = ConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement("update advant.site set name = ? where id = ?");
            ps.setString(1, site.getSiteName());
            ps.setInt(2, site.getSiteId());
            log.info(ps.toString());
            return ps.executeUpdate();
        } catch (Exception e) {
            log.error("Error while updating site name :" + e);
        } finally {
            ConnectionManager.closeConnection();
        }
        return 0;
    }
}