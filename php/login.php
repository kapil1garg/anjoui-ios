<?php

include 'index.php';

// get values from POST
$email = $_POST['email'];
$pass  = $_POST['password'];

// query database for user
$query = "SELECT *
          FROM `Customers`
          WHERE `email` = '$email'";
$results = mysqli_query($link, $query);

// parse rows
$rows    = array();
while ($r = mysqli_fetch_assoc($results)) {
    $rows[] = $r;
}

// validate user
// if only one instance of email check password and return if correct, otherwise error
if (count($rows) == 1) {
    $stored_hash = $rows[0]['password'];
    if (password_verify($pass, $stored_hash)) {
        $rows[0]['password'] = "";
        sendResponse(200, json_encode($rows[0], JSON_NUMERIC_CHECK));
    } else {
        sendResponse(403, "Password is incorrect.");
    }
} else {
    sendResponse(403, "Email does not exist.");
}

mysqli_close($link);
?>
