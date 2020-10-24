<?php
$servername = "localhost";
$username = "end_user_skolka";
$password = "7~?f,nCsE!QBvU,$<C32";
$dbname = "skolka";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);


echo "Connected successfully";

function select($sql) {

    global $conn;

    if ($result =
    $conn->query($sql)) {

		echo "<table style=\"border-collapse:collapse;width:100%;\">\n";

		$first = $result->fetch_assoc();

		echo "<tr>\n";
		foreach ($first as $key => $value) {
			echo "<th style=\"border:1px solid #333;padding: 4px;background:#ccc;\">$key</th>\n";
		}
		echo "</tr>\n";

		$result->data_seek(0);

		while ($row = $result->fetch_assoc()) {
			echo "<tr>\n";
			foreach ($row as $key => $value) {
				echo "<td style=\"border:1px solid #333;padding: 4px;\">$value</td>\n";
			}
			echo "</tr>\n";
    }
		echo "</table>\n";

    } elseif ($conn->error) {
        die('Query error: ' . $conn->error);
	} else {
		echo 'No result';
	}

}
$sql = "SELECT child.first_name AS 'child name', child.last_name AS 'child surname', GROUP_CONCAT(event.name) AS 'event'
FROM child
JOIN child_event ON child.id = child_event.child_id
JOIN event ON event.id = child_event.event_id
GROUP BY (child.first_name)";
select($sql);
?>