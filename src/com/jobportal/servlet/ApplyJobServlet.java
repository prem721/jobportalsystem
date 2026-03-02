	package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles job application submissions by job seekers.
 */
public class ApplyJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;  // Fixes serial warning
    private final JobDAO jobDAO = new JobDAO();       // DAO instance for DB operations

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String message;

        try {
            // Parse jobId and userId safely
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            int userId = Integer.parseInt(request.getParameter("userId")); // Replace with session-based user later

            boolean applied = jobDAO.applyForJob(jobId, userId);

            if (applied) {
                message = "Application submitted successfully!";
            } else {
                message = "Application failed. Please try again.";
            }

        } catch (NumberFormatException e) {
            message = "Invalid Job or User ID format!";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred while applying for the job.";
            e.printStackTrace();
        }

        // Redirect back to job listings with status message
        response.sendRedirect("jobs.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
}
