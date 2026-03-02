<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.dao.JobDAO" %>
<%@ page import="com.jobportal.model.Job" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Job</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 40px; }
        h1 { color: #333; }
        form { background: white; padding: 20px; border-radius: 8px; max-width: 400px; 
               box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
        input, textarea { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ccc; border-radius: 4px; }
        input[type=submit] { background-color: #007bff; color: white; border: none; cursor: pointer; }
        input[type=submit]:hover { background-color: #0056b3; }
    </style>
</head>
<body>

<%
    // ---- Validate jobId ----
    String jobIdParam = request.getParameter("jobId");

    if (jobIdParam == null) {
%>
        <p style="color:red;">Invalid Job ID.</p>
<%
    } else {

        int jobId = Integer.parseInt(jobIdParam);

        JobDAO dao = new JobDAO();
        Job job = dao.getJobById(jobId);

        if (job == null) {
%>
            <p style="color:red;">Job not found.</p>
<%
        } else {
%>

<h1>Apply for: <%= job.getTitle() %></h1>

<form action="ApplyJobServlet" method="post">

    <input type="hidden" name="jobId" value="<%= job.getId() %>">
    <input type="hidden" name="userId" value="1"> <!-- temp user -->

    <label>Your Name:</label>
    <input type="text" name="name" required>

    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Resume (paste text):</label>
    <textarea name="resume" rows="5" required></textarea>

    <input type="submit" value="Submit Application">
</form>

<%
        }
    }
%>

</body>
</html>
