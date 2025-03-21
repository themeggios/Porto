<?php

$pdo = new PDO("mysql:host=localhost;dbname=porto;charset=utf8mb4", "root", "");

$stmt = $pdo->query("SELECT MAX(id) AS id FROM Navi");
$row = $stmt->fetch(PDO::FETCH_ASSOC);

$id = $row['id'];

?>