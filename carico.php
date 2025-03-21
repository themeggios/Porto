<?php
require "db.php";

$stmt = $pdo->prepare("CALL RegistraOperazione(?, ?, ?, ?)");
$stmt->execute([$id, 2, 'carico', 50]); // 50 pezzi caricati

echo "<script>
alert('Carico effettuato');
window.location.href = 'index.php';
</script>";
?>