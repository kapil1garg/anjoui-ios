<?php
include 'index.php';

$first_name = getPost('first_name', NULL);
$last_name = getPost('last_name', NULL);
$city = getPost('city', NULL);
$state = getPost('state', NULL);
$country = getPost('country', NULL);
$phone_number = getPost('phone_number', NULL);
$longitude = getPost('longitude', NULL);
$latitude = getPost('latitude', NULL);
$description = getPost('description', NULL);
$photo_id = getPost('photo_id', NULL);
$password = getPost('password', NULL);
$email = getPost('email', NULL);

$iscook = $_POST['cook'];
$iseater = $_POST['eater'];

// hash password
$hash_password = pw_hash($password);

// create cook and eater IDs
$eater_id = md5('diner' . strtolower($first_name) . strtolower($email) . strtolower($last_name) . 'id');
if ($iscook == 'True') {
  $cook_id = md5('cook' . strtolower($first_name) . strtolower($email) . strtolower($last_name) . 'id');
} else {
    $cook_id = NULL;
}

// check if new user is already in database
$query   = "SELECT count(`customer_id`) as 'number'
            FROM `Customers`
            WHERE `email` = '$email'";
$results = mysqli_fetch_assoc(mysqli_query($link, $query));

// add user if not in database
if ($results['number'] == 0) {
    $query = "INSERT INTO `Customers`
                (`cook_id`, `eater_id`, `first_name`, `last_name`, `city`, `state`,`country`, `phone_number`,
                    `longitude`, `latitude`, `description`, `photo_id`, `password`, `email`)
              VALUES
                ('$cook_id', '$eater_id', '$first_name', '$last_name', '$city', '$state', '$country', '$phone_number',
                    '$longitude', '$latitude', '$description', '$photo_id', '$hash_password', '$email')";
    if (mysqli_query($link, $query)) {
        sendResponse(200, 'User successfully created.');
    } else {
        sendResponse(500, 'Upload error.');
    }
} else {
    sendResponse(409, "User email already exists.");
}

// echo $results['number'];

// create user if
// $rows = array();
// while ($r = mysqli_fetch_assoc($results)) {
//     $rows[] = $r;
// }



// // check if user is in database and if they have admin privileges
// $query   = "SELECT count(`id`) as 'valid_token',
//                        `admin` as 'valid_admin'
//             FROM `ar_users`
//             WHERE `idtoken` = '$user_token'";
// $results = mysqli_fetch_assoc(mysqli_query($con, $query));

// $user_exists = (int) ($results["valid_token"]);
// $user_admin  = (int) ($results["valid_admin"]);

// // create if valid, otherwise error
// if ($user_exists == 1 && $user_admin == 1) {
//     if ($rows[0]['number'] == 0) {
//         // add new user
//         $query = "INSERT INTO `ar_users` (`name`, `email`, `code`, `idtoken`)
//                   VALUES ('$name', '$email', '$hash_pass', '$token_code')";

//         if (!mysqli_query($con, $query)) {
//             echo "Somethings wrong here: $query.";
//         } else {
//             echo "User \"$name\" successfully created.";
//         }
//     } else {
//         echo "Email \"$email\" already exists.";
//     }
// } else {
//     echo "You do not have privileges to create or modify users.";
// }

mysqli_close($link);
?>