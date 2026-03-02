<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Portal System</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #007bff, #00d4ff);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .container {
            background: rgba(255, 255, 255, 0.15);
            padding: 40px 60px;
            border-radius: 12px;
            backdrop-filter: blur(12px);
            text-align: center;
            box-shadow: 0 4px 30px rgba(0,0,0,0.1);
        }

        h1 {
            margin-bottom: 30px;
            font-size: 32px;
            letter-spacing: 1px;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 10px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
            transition: 0.3s ease;
            border: 2px solid white;
            color: white;
        }

        .btn:hover {
            background: white;
            color: #007bff;
            transform: scale(1.07);
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Welcome to Job Portal System</h1>

        <a href="jobs.jsp" class="btn">View Jobs</a>
        <a href="post-job.jsp" class="btn">Post a Job</a>
    </div>
</body>
</html>
