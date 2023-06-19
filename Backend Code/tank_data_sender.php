<?php
header("Access-Control-Allow-Origin: *"); // Allow requests from any origin
header("Content-Type: application/json; charset=UTF-8"); // Set response content type to JSON
header("Access-Control-Allow-Methods: GET, POST, OPTIONS"); // Specify the allowed HTTP methods
header("Access-Control-Allow-Headers: Content-Type, Authorization"); // Specify the allowed request headers
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Connect to the MySQL database
    $servername = 'localhost';
    $username = 'your_username';
    $password = 'your_password';
    $database = 'your_database';

    $conn = new mysqli($servername, $username, $password, $database);

    // Check the connection
    if ($conn->connect_error) {
        die('Connection failed: ' . $conn->connect_error);
    }

    // Retrieve the latest tank data from the database
    $sql = "SELECT value FROM tank_data ORDER BY id DESC LIMIT 1";
    $result = $conn->query($sql);
    $tankData = ($result->num_rows > 0) ? $result->fetch_assoc()['value'] : '0';

    // Send the response to the Flutter app
    $response = [
        'status' => 'success',
        'data' => $tankData,
    ];
    header('Content-Type: application/json');
    echo json_encode($response);

    // Close the database connection
    $conn->close();
} else {
    $response = [
        'status' => 'error',
        'message' => 'Invalid request method',
    ];
    header('Content-Type: application/json');
    echo json_encode($response);
}
?>
