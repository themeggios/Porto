<?php
require "db.php";

$stmt = $pdo->prepare("CALL ArrivoNave(?, ?, ?)");
$stmt->execute(["Neptunia", "2025-03-20 10:00:00", "2025-03-22 18:00:00"]);

echo "<script>
alert('Nave arrivata');
window.location.href = 'index.php';
</script>;";
?>