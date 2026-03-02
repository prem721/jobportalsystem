package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle listing of all available jobs.
 */
public class JobListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;  // Fixes serialization warning

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            JobDAO jobDAO = new JobDAO();
            List<Job> jobs = jobDAO.getAllJobs();

            // Attach job list to request
            request.setAttribute("jobs", jobs);

            // Forward to JSP view
            RequestDispatcher dispatcher = request.getRequestDispatcher("jobs.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Forward to an error page (optional)
            request.setAttribute("errorMessage", "Unable to load job listings.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
