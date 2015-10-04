<?php
include 'index.php';

$first_name = $_POST['first_name'];
$last_name = $_POST['last_name'];
$city = $_POST['city'];
$state = $_POST['state'];
$country = $_POST['country'];
$phone_number = $_POST['phone_number'];
$longitude = $_POST['longitude'];
$latitude = $_POST['latitude'];
$description = $_POST['description'];
$photo_id = $_POST['photo_id'];
$password = $_POST['password'];
$email = $_POST['email'];

$iscook = $_POST['cook'];
$iseater = $_POST['eater'];

echo $_POST;


// hash password
$hash_password = pw_hash($password);

// create cook and eater IDs
$cook_id = NULL;
$eater_id = md5('diner' . strtolower($first_name) . strtolower($email) . strtolower($last_name) . 'id');
if ($iscook == 'True') {
  $cook_id = md5('cook' . strtolower($first_name) . strtolower($email) . strtolower($last_name) . 'id');
}

// check if new user is already in database
$query   = "SELECT count(`customer_id`) as 'number'
            FROM `Customers`
            WHERE `email` = '$email'";
$results = mysqli_fetch_assoc(mysqli_query($link, $query));
echo $results['number'];

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