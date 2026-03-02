<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Post a Job</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f0f4ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            padding: 35px 50px;
            border-radius: 12px;
            width: 420px;
            box-shadow: 0px 4px 25px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            font-weight: bold;
            color: #444;
        }

        input[type=text], textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0 16px 0;
            border: 1px solid #bbb;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 15px;
        }

        textarea {
            resize: none;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            font-size: 17px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .btn:hover {
            background: #0056b3;
        }

        .home-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .home-link:hover {
            text-decoration: underline;
        }
    </style>

</head>
<body>

<div class="container">
    <h1>Post a Job</h1>

    <form action="PostJobServlet" method="post">

        <label>Job Title</label>
        <input type="text" name="title" required>

        <label>Company</label>
        <input type="text" name="company" required>

        <label>Location</label>
        <input type="text" name="location" required>

        <label>Description</label>
        <textarea name="description" rows="5" required></textarea>

        <input type="submit" class="btn" value="Post Job">
    </form>

    <a href="index.jsp" class="home-link">← Back to Home</a>
</div>

</body>
</html>
