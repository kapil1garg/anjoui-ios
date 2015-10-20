<?php

include 'index.php';

// query database for all postes dishes
$query   = "SELECT *
          FROM `Dishes`";
$results = mysqli_query($link, $query);

if ($results) {
    // parse rows into an array of json objects
    $rows = array();
    while ($r = mysqli_fetch_assoc($results)) {
        $rows[] = $r;
    }

    sendResponse(200, json_encode($rows, JSON_NUMERIC_CHECK));
} else {
    sendResponse(500, 'Dishes could not be retrieved.');
}

mysqli_close($link);

?>