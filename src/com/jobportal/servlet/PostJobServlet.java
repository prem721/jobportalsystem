package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Servlet to handle posting a new job.
 */
public class PostJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L; // removes serialization warning
    private final JobDAO jobDAO = new JobDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String company = request.getParameter("company");
        String location = request.getParameter("location");
        String description = request.getParameter("description");

        String message;

        try {
            Job job = new Job();
            job.setTitle(title);
            job.setCompany(company);
            job.setLocation(location);
            job.setDescription(description);

            boolean success = jobDAO.addJob(job);

            message = success ? "Job Posted Successfully!" : "Failed to Post Job!";

        } catch (Exception e) {
            e.printStackTrace();
            message = "Error occurred while posting job!";
        }

        // Redirect to job list with a message
        response.sendRedirect("jobs.jsp?message=" + message);
    }
}

