<%@ page import="java.util.List" %>
<%@ page import="com.jobportal.model.Job" %>
<%@ page import="com.jobportal.dao.JobDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Listings</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <style>
        :root{
            --bg: #f5f7fb;
            --card: #ffffff;
            --muted: #6b7280;
            --accent: #2563eb;
            --accent-dark: #174ab4;
            --success: #16a34a;
            --radius: 12px;
            --gap: 18px;
            --max-width: 1100px;
            --shadow: 0 6px 18px rgba(20,25,40,0.08);
        }

        *{box-sizing:border-box}
        body{
            margin:0;
            font-family: "Inter", "Segoe UI", Roboto, Arial, sans-serif;
            background: linear-gradient(180deg, #eef2ff 0%, var(--bg) 100%);
            color:#0f172a;
            padding:32px 20px;
            -webkit-font-smoothing:antialiased;
        }

        .wrap{
            max-width: var(--max-width);
            margin: 0 auto;
        }

        header.topbar{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:16px;
            margin-bottom:24px;
        }

        .brand{
            display:flex;
            gap:12px;
            align-items:center;
        }
        .logo {
            width:48px;height:48px;border-radius:10px;
            background: linear-gradient(135deg,#60a5fa,#06b6d4);
            display:flex;align-items:center;justify-content:center;color:white;font-weight:700;
            box-shadow: 0 6px 18px rgba(6,78,59,0.06);
            font-family: "Segoe UI",sans-serif;
        }
        h1 { font-size:20px; margin:0; }
        p.lead { margin:0; color:var(--muted); font-size:14px; }

        .actions {
            display:flex;
            gap:10px;
            align-items:center;
        }

        .btn {
            background:var(--accent);
            color:white;
            border:none;
            padding:10px 14px;
            border-radius:10px;
            font-weight:600;
            cursor:pointer;
            text-decoration:none;
            display:inline-flex;
            gap:10px;
            align-items:center;
            box-shadow: 0 6px 18px rgba(37,99,235,0.12);
            transition:transform .12s ease, box-shadow .12s ease;
        }
        .btn:hover{ transform:translateY(-3px); box-shadow: 0 16px 30px rgba(37,99,235,0.12); }
        .btn.ghost {
            background: transparent; color:var(--accent); border:1px solid rgba(37,99,235,0.12);
            box-shadow:none; font-weight:600;
        }

        .controls {
            display:flex;
            gap:12px;
            flex-wrap:wrap;
            align-items:center;
        }
        .search {
            display:flex;
            align-items:center;
            gap:8px;
            background:var(--card);
            padding:8px 10px;
            border-radius:10px;
            box-shadow: var(--shadow);
            min-width:240px;
        }
        .search input {
            border:0; outline:none; font-size:14px; padding:6px; width:220px;
        }

        main.content {
            margin-top:18px;
        }

        .grid {
            display:grid;
            grid-template-columns: repeat(auto-fill, minmax(280px,1fr));
            gap:var(--gap);
            align-items:stretch;
        }

        .card {
            background:var(--card);
            border-radius:var(--radius);
            padding:16px;
            box-shadow: var(--shadow);
            display:flex;
            flex-direction:column;
            justify-content:space-between;
            min-height:180px;
        }

        .job-header {
            display:flex;
            align-items:center;
            gap:12px;
        }
        .job-avatar{
            width:56px;height:56px;border-radius:10px;background:#eef2ff;color:var(--accent);
            display:flex;align-items:center;justify-content:center;font-weight:700;
            font-size:18px;
        }
        .job-title { font-size:16px; margin:0; }
        .job-company { margin:2px 0 0 0; color:var(--muted); font-size:13px }

        .job-meta { margin-top:12px; color:var(--muted); font-size:13px; flex:1; }
        .job-desc {
            margin-top:10px; color:#111827; font-size:14px; line-height:1.35;
            max-height:72px; overflow:hidden; text-overflow:ellipsis;
        }

        .card-footer {
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-top:14px;
        }

        .apply-btn {
            background: linear-gradient(90deg,var(--accent),var(--accent-dark));
            color:white; padding:8px 12px; border-radius:8px; border:none;
            cursor:pointer; font-weight:600; text-decoration:none;
        }
        .apply-btn:hover{ transform:translateY(-2px); }

        .pill {
            font-size:12px;
            padding:6px 8px;
            border-radius:999px;
            background:#eef2f5;
            color:#0b6b4a;
            font-weight:600;
            border:1px solid rgba(11,107,74,0.06);
        }

        .message {
            padding:12px 14px;
            border-radius:10px;
            background: #ecfdf5;
            color: #065f46;
            border:1px solid rgba(6,95,70,0.08);
            margin-bottom:16px;
            display:inline-block;
        }

        footer.app-foot {
            margin-top:30px;
            color:var(--muted);
            font-size:13px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:10px;
            flex-wrap:wrap;
        }

        /* responsive tweaks */
        @media (max-width:600px){
            .search input{ width:120px; }
            .logo { width:44px; height:44px; font-size:16px }
            .brand p.lead { display:none; }
            body { padding:20px; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <header class="topbar">
        <div class="brand">
            <div class="logo">JP</div>
            <div>
                <h1>Job Portal System</h1>
                <p class="lead">Find and apply to jobs — quick and simple.</p>
            </div>
        </div>

        <div class="actions">
            <div class="controls">
                <div class="search" role="search" aria-label="Search jobs">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                        <path d="M21 21l-4.35-4.35" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round"/>
                        <circle cx="11" cy="11" r="6" stroke="#9CA3AF" stroke-width="2" />
                    </svg>
                    <input id="searchInput" type="text" placeholder="Search title, company or location...">
                </div>
            </div>

            <a class="btn ghost" href="post-job.jsp">Post a Job</a>
            <a class="btn" href="index.jsp">Home</a>
        </div>
    </header>

    <main class="content">
        <%
            JobDAO jobDAO = new JobDAO();
            List<Job> jobs = jobDAO.getAllJobs();
            String message = request.getParameter("message");
            if(message != null && !message.isEmpty()){
        %>
            <div class="message"><%= message %></div>
        <%
            }
        %>

        <section class="grid" id="jobsGrid">
            <%
                if (jobs == null || jobs.isEmpty()) {
            %>
                <div style="grid-column:1/-1; background:var(--card); padding:24px; text-align:center; border-radius:12px; box-shadow:var(--shadow);">
                    <strong>No jobs found.</strong>
                    <p style="margin:8px 0 0;color:var(--muted)">Try posting a job or refresh later.</p>
                </div>
            <%
                } else {
                    for (Job job : jobs) {
            %>
                <article class="card" data-title="<%= (job.getTitle()==null? "": job.getTitle().toLowerCase()) %>"
                         data-company="<%= (job.getCompany()==null? "": job.getCompany().toLowerCase()) %>"
                         data-location="<%= (job.getLocation()==null? "": job.getLocation().toLowerCase()) %>">

                    <div>
                        <div class="job-header">
                            <div class="job-avatar"><%= (job.getCompany()!=null && job.getCompany().length()>0) ? job.getCompany().substring(0,1).toUpperCase() : "J" %></div>
                            <div>
                                <p class="job-title"><%= job.getTitle() %></p>
                                <p class="job-company"><%= job.getCompany() %> • <span style="color:var(--muted)"><%= job.getLocation() %></span></p>
                            </div>
                        </div>

                        <div class="job-desc"><%= job.getDescription() %></div>
                    </div>

                    <div class="card-footer">
                        <span class="pill">Job ID: <%= job.getId() %></span>

                       <a href="apply.jsp?jobId=<%= job.getId() %>" class="apply-btn" style="text-decoration:none;">
    Apply
</a>

                    </div>
                </article>
            <%
                    }
                }
            %>
        </section>

        <footer class="app-foot">
            <div>Showing <strong><%= (jobs!=null? jobs.size(): 0) %></strong> job(s)</div>
            
        </footer>
    </main>
</div>

<script>
    // client-side quick filter (works in-browser without server)
    (function(){
        var input = document.getElementById('searchInput');
        var grid = document.getElementById('jobsGrid');
        if(!input) return;
        input.addEventListener('input', function(){
            var q = input.value.trim().toLowerCase();
            var cards = grid.querySelectorAll('.card');
            if(!q){
                cards.forEach(c => c.style.display = '');
                return;
            }
            cards.forEach(function(card){
                var title = card.getAttribute('data-title') || '';
                var comp = card.getAttribute('data-company') || '';
                var loc = card.getAttribute('data-location') || '';
                var visible = title.includes(q) || comp.includes(q) || loc.includes(q);
                card.style.display = visible ? '' : 'none';
            });
        });
    })();
</script>
</body>
</html>
