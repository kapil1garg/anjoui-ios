<?php
// include 'init.php';

// $email = $_REQUEST['name'];
// $pass  = $_REQUEST['password'];

// // get user with $email
// // $query = "SELECT *
// //           FROM `Customers`
// //           WHERE `first_name` = '$email'";
// $query = "SELECT *
//           FROM `Customers`
//           WHERE `first_name` = \"test\"";
// $results = mysqli_query($link, $query);

// // if only one instance of email check password and return if correct, otherwise error
// // if (count($rows) == 1) {
// //     $stored_hash = $rows[0]['code'];
// //     if (pw_verify($pass, $stored_hash)) {
// //         $rows[0]['code'] = "";
// //         echo json_encode($rows[0], JSON_NUMERIC_CHECK);
// //     } else {
// //         echo 'Fail';
// //     }
// // } else {
// //     echo 'Fail';
// // }
// //
// // Printing results in HTML
// echo "<table>\n";
// while ($line = mysqli_fetch_assoc($results)) {
//     echo "\t<tr>\n";
//     foreach ($line as $col_value) {
//         echo "\t\t<td>$col_value</td>\n";
//     }
//     echo "\t</tr>\n";
// }
// echo "</table>\n";

include 'index.php';

// $query = "SELECT *
//               FROM `Customers`
//               WHERE `email` = 'test2@anjoui.com'";
//     echo $query;
//     $results = mysqli_query($link, $query);

//     echo "<table>\n";
//     while ($line = mysqli_fetch_assoc($results)) {
//         echo "\t<tr>\n";
//         foreach ($line as $col_value) {
//             echo "\t\t<td>$col_value</td>\n";
//         }
//         echo "\t</tr>\n";
//     }
//     echo "</table>\n";

// variables from request
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
    if (pw_verify($pass, $stored_hash)) {
        $rows[0]['password'] = "";

        sendResponse(200, json_encode($rows[0], JSON_NUMERIC_CHECK));
    } else {
        sendResponse(403, "Password is incorrect.");
    }
} else {
    sendResponse(403, "Email does not exist.");
}

// class LoginUser {

//     // private $db;

//     // // Constructor - open DB connection
//     // function __construct() {
//     //     $this->db = new mysqli('localhost', 'username', 'password', 'promos');
//     //     $this->db->autocommit(FALSE);
//     // }

//     // // Destructor - close DB connection
//     // function __destruct() {
//     //     $this->db->close();
//     // }

//     function seeUsers($link) {
//         $query = "SELECT *
//                   FROM `Customers`";
//         $results = mysqli_query($link, $query);

//         // Printing results in HTML
//         // echo "<table>\n";
//         // while ($line = mysqli_fetch_assoc($results)) {
//         //     echo "\t<tr>\n";
//         //     foreach ($line as $col_value) {
//         //         echo "\t\t<td>$col_value</td>\n";
//         //     }
//         //     echo "\t</tr>\n";
//         // }
//         // echo "</table>\n";

//         $output = array();
//         while ($line = mysqli_fetch_assoc($results)) {
//             array_push($output, json_encode($line));
//         }
//         sendResponse(200, json_encode($output));
//     }

//     function validateUser() {

//     }

//     // Main method to redeem a code
//     // function redeem() {

//     //     // Check for required parameters
//     //     if (isset($_POST["rw_app_id"]) && isset($_POST["code"]) && isset($_POST["device_id"])) {

//     //         // Put parameters into local variables
//     //         $rw_app_id = $_POST["rw_app_id"];
//     //         $code = $_POST["code"];
//     //         $device_id = $_POST["device_id"];

//     //         // Look up code in database
//     //         $user_id = 0;
//     //         $stmt = $this->db->prepare('SELECT id, unlock_code, uses_remaining FROM rw_promo_code WHERE rw_app_id=? AND code=?');
//     //         $stmt->bind_param("is", $rw_app_id, $code);
//     //         $stmt->execute();
//     //         $stmt->bind_result($id, $unlock_code, $uses_remaining);
//     //         while ($stmt->fetch()) {
//     //             break;
//     //         }
//     //         $stmt->close();

//     //         // Bail if code doesn't exist
//     //         if ($id <= 0) {
//     //             sendResponse(400, 'Invalid code');
//     //             return false;
//     //         }

//     //         // Bail if code already used
//     //         if ($uses_remaining <= 0) {
//     //             sendResponse(403, 'Code already used');
//     //             return false;
//     //         }

//     //         // Check to see if this device already redeemed
//     //         $stmt = $this->db->prepare('SELECT id FROM rw_promo_code_redeemed WHERE device_id=? AND rw_promo_code_id=?');
//     //         $stmt->bind_param("si", $device_id, $id);
//     //         $stmt->execute();
//     //         $stmt->bind_result($redeemed_id);
//     //         while ($stmt->fetch()) {
//     //             break;
//     //         }
//     //         $stmt->close();

//     //         // Bail if code already redeemed
//     //         if ($redeemed_id > 0) {
//     //             sendResponse(403, 'Code already used');
//     //             return false;
//     //         }

//     //         // Add tracking of redemption
//     //         $stmt = $this->db->prepare("INSERT INTO rw_promo_code_redeemed (rw_promo_code_id, device_id) VALUES (?, ?)");
//     //         $stmt->bind_param("is", $id, $device_id);
//     //         $stmt->execute();
//     //         $stmt->close();

//     //         // Decrement use of code
//     //         $this->db->query("UPDATE rw_promo_code SET uses_remaining=uses_remaining-1 WHERE id=$id");
//     //         $this->db->commit();

//     //         // Return unlock code, encoded with JSON
//     //         $result = array(
//     //             "unlock_code" => $unlock_code,
//     //         );
//     //         sendResponse(200, json_encode($result));
//     //         return true;
//     //     }
//     //     sendResponse(400, 'Invalid request');
//     //     return false;

//     // }

// }

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the RedeemAPI class and calls the redeem method
// $api = new LoginUser;
// $api->seeUsers($link);

mysqli_close($link);
?>