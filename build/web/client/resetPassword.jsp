<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #181C14;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .forgot-pass {
                display: block;
                text-align: center;
                margin-top: 10px;
                font-size: 12px;
                color: #181C14; /* Dark text */
            }
            .forgot-pass:hover {
                color: #eb5d1e; /* Orange hover */
            }
        .reset-password-container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
            background: #ECDFCC;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .reset-password-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #181C14;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #181C14;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #181C14; /* Dark border */
                border-radius: 8px;
                background-color: #ECDFCC; /* Light beige background */
                color: #181C14; /* Dark text */
        }
        .btn-submit {
            width: 100%;
            padding: 10px;
            font-size: 16px;
             background-color: #eb5d1e;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #d04a0e;
        }
    </style>
</head>
<body>
    <div class="reset-password-container">
        <h2>Reset Password</h2>
        <form action="updatePassword.jsp" method="post">
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>
            </div>
            <button type="submit" class="btn-submit">Reset Password</button>
            <a href="login.jsp" class="forgot-pass">Back To Login</a>
        </form>
    </div>
</body>
</html>