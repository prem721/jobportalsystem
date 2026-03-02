package com.jobportal.dao;

import com.jobportal.model.Application;
import java.sql.*;

public class ApplicationDAO {
    public void addApplication(Application app) throws SQLException {
        String sql = "INSERT INTO applications (job_id, name, email, resume) VALUES (?, ?, ?, ?)";
        try(Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, app.getJobId());
            ps.setString(2, app.getName());
            ps.setString(3, app.getEmail());
            ps.setString(4, app.getResume());
            ps.executeUpdate();
        }
    }
}