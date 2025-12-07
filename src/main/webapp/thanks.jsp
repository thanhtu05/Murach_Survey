<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>

<body>
<h1>Thanks for joining our email list</h1>

<p>Here is the information that you entered:</p>

<div class="user-info">
    <label>Email:</label>
    <span>${user.email}</span><br>
    <label>First Name:</label>
    <span>${user.firstName}</span><br>
    <label>Last Name:</label>
    <span>${user.lastName}</span><br>
    <label>Date of Birth:</label>
    <span>${user.dob}</span><br>
</div>

<h2>Survey Details</h2>
<div class="survey-details">
    <label>How you heard about us:</label>
    <span>${user.source}</span><br>

    <label>Receive CD Announcements:</label>
    <span>${user.receiveCDs}</span><br>

    <label>Receive Email Announcements:</label>
    <span>${user.receiveEmail}</span><br>

    <label>Preferred Contact Method:</label>
    <span>${user.contactMethod}</span><br>
</div>

<p>To enter another email address, click on the Back
    button in your browser or the Return button shown
    below.</p>

<form action="emailList" method="get">
    <input type="hidden" name="action" value="join">
    <input type="submit" value="Return">
</form>

</body>
</html>