<style>

table {
    border-collapse: collapse;
}

tr,td,th,table {
    border: 1px solid black;
    padding: 8px;
}
</style>


<?php
if (false != $_POST['message']) {
    $servername = "zip2000_db";
    $username = getenv('MYSQL_USER');
    $password = getenv('MYSQL_PASSWORD');
    $dbname = getenv('MYSQL_DATABASE');

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $stmt = $conn->prepare("INSERT INTO messages(text) VALUES (?)");
    $stmt->bind_param("s", $text);

    $text = $_POST["message"];
    $stmt->execute();

    $stmt->close();
    $conn->close();
}
?>

<h1>Last 10 messages</h1>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Message</th>
        <th>Date</th>

        <?php

        $host = 'http://zip2000_node:' . getenv('NODE_PORT') . '/messages';

        $ch = curl_init($host);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        curl_close($ch);

        if (false === $output) {
        } else {
            $json = json_decode($output, true);
            foreach ($json as $message) {
                echo '<tr>';
                echo '<td>' . $message['id'] . '</td>';
                echo '<td>' . $message['text'] . '</td>';
                $time = strtotime($message['ts']);
                echo '<td>' . date('Y-m-d H:i:s e',$time) . '</td>';
                echo '</tr>';
            }
        }
        ?>
    </tr>
</table>


<h1>Add your own message</h1>

<form action="index.php" method="post">
    Message: <input type="text" name="message" size="64" maxlength="64" placeholder="Enter your message here (64 characters max)"> <input type="submit">
</form>
