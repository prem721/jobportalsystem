package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    // -------------------------------
    // 1. ADD NEW JOB (returns boolean)
    // -------------------------------
    public boolean addJob(Job job) {
        // Uses RETURN_GENERATED_KEYS for debugging; still returns boolean.
        String sql = "INSERT INTO jobs (title, company, location, description) VALUES (?, ?, ?, ?)";
        if (job == null) {
            System.out.println("addJob: job is null");
            return false;
        }

        Connection conn = null;
        PreparedStatement pst = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("addJob: DB connection is null");
                return false;
            }

            pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, job.getTitle());
            pst.setString(2, job.getCompany());
            pst.setString(3, job.getLocation());
            pst.setString(4, job.getDescription());

            int rows = pst.executeUpdate();
            if (rows <= 0) {
                System.out.println("addJob: no rows inserted (rows=" + rows + ")");
                return false;
            }

            try (ResultSet keys = pst.getGeneratedKeys()) {
                if (keys != null && keys.next()) {
                    int generatedId = keys.getInt(1);
                    job.setId(generatedId); // set id back to bean for caller if needed
                    System.out.println("addJob: inserted job id = " + generatedId);
                }
            } catch (Exception ex) {
                // don't fail because of generated keys reading
                ex.printStackTrace();
            }

            return true;

        } catch (Exception e) {
            System.out.println("addJob: SQLException/Exception occurred");
            e.printStackTrace();
            return false;
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // -------------------------------
    // Alternative: addJob and return generated id (0 if failed)
    // -------------------------------
    public int addJobReturnId(Job job) {
        String sql = "INSERT INTO jobs (title, company, location, description) VALUES (?, ?, ?, ?)";
        if (job == null) return 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pst.setString(1, job.getTitle());
            pst.setString(2, job.getCompany());
            pst.setString(3, job.getLocation());
            pst.setString(4, job.getDescription());

            int rows = pst.executeUpdate();
            if (rows <= 0) return 0;

            try (ResultSet rs = pst.getGeneratedKeys()) {
                if (rs != null && rs.next()) {
                    int id = rs.getInt(1);
                    job.setId(id);
                    return id;
                }
            }
            return 0;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    // -------------------------------
    // 2. GET ALL JOBS
    // -------------------------------
    public List<Job> getAllJobs() {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT * FROM jobs";

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("getAllJobs: DB connection is null");
                return list;
            }

            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();

            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setDescription(rs.getString("description"));
                list.add(job);
            }

        } catch (Exception e) {
            System.out.println("getAllJobs: exception");
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        return list;
    }

    // -------------------------------
    // 3. GET JOB BY ID
    // -------------------------------
    public Job getJobById(int id) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        Job job = null;

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("getJobById: DB connection is null");
                return null;
            }

            pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            if (rs.next()) {
                job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            System.out.println("getJobById: exception");
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        return job;
    }

    // -------------------------------
    // 4. APPLY FOR JOB (simple: jobId + userId)
    // -------------------------------
    public boolean applyForJob(int jobId, int userId) {
        String sql = "INSERT INTO applications (job_id, user_id) VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("applyForJob: DB connection is null");
                return false;
            }

            pst = conn.prepareStatement(sql);
            pst.setInt(1, jobId);
            pst.setInt(2, userId);

            int rows = pst.executeUpdate();
            System.out.println("applyForJob: rowsInserted = " + rows);
            return rows > 0;

        } catch (Exception e) {
            System.out.println("applyForJob: exception");
            e.printStackTrace();
            return false;
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // -------------------------------
    // 5. APPLY FOR JOB (with applicant details)
    //    use this if your applications table has name/email/resume columns
    // -------------------------------
    public boolean applyForJob(int jobId, int userId, String name, String email, String resume) {
        String sql = "INSERT INTO applications (job_id, user_id, name, email, resume) VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("applyForJob(details): DB connection is null");
                return false;
            }

            pst = conn.prepareStatement(sql);
            pst.setInt(1, jobId);
            pst.setInt(2, userId);
            pst.setString(3, name);
            pst.setString(4, email);
            pst.setString(5, resume);

            int rows = pst.executeUpdate();
            System.out.println("applyForJob(details): rowsInserted = " + rows);
            return rows > 0;

        } catch (Exception e) {
            System.out.println("applyForJob(details): exception");
            e.printStackTrace();
            return false;
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
