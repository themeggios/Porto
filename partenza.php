<?php
require "db.php";

$stmt = $pdo->prepare("CALL PartenzaNave(?, ?)");
$stmt->execute([$id, "2025-03-22 20:00:00"]);

echo "<script>
alert('Nave partita');
window.location.href = 'index.php';
</script>";
?>