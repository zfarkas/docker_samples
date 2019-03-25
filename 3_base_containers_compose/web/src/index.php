<?php

$host = 'http://zip2000_node:5000/counter';

$ch = curl_init($host);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$output = curl_exec($ch);
curl_close($ch);

if (false === $output) {
  echo 'Failed to connect to "' . $host . '"!';
} else {
  echo 'Data received from node: ' . $output;
}


echo '<br/>';

$host = 'http://zip2000_node:5000/';

$ch = curl_init($host);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$output = curl_exec($ch);
curl_close($ch);

if (false === $output) {
  echo 'Failed to connect to "' . $host . '"!';
} else {
  echo 'And this is the message from node: ' . $output;
}

?>
