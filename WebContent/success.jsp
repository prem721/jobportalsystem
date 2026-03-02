<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Success</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #4CAF50, #00c853);
            font-family: "Segoe UI", Arial, sans-serif;
            color: white;
        }

        .box {
            background: rgba(255, 255, 255, 0.20);
            padding: 40px 60px;
            border-radius: 12px;
            backdrop-filter: blur(10px);
            text-align: center;
            box-shadow: 0 4px 18px rgba(0,0,0,0.15);
        }

        h1 {
            margin-bottom: 15px;
            font-size: 32px;
            font-weight: 600;
        }

        p {
            font-size: 18px;
            margin-bottom: 25px;
        }

        a {
            padding: 12px 25px;
            background: white;
            color: #2e7d32;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: 0.3s;
            border: 2px solid white;
        }

        a:hover {
            background: transparent;
            color: white;
            border-color: white;
        }
    </style>
</head>

<body>

<div class="box">
    <h1>Operation Successful!</h1>
    <p>Your request has been processed successfully.</p>
    <a href="index.jsp">Return to Home</a>
</div>

</body>
</html>

