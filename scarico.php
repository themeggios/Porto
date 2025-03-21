<?php
require "db.php";

$stmt = $pdo->prepare("CALL RegistraOperazione(?, ?, ?, ?)");
$stmt->execute([$id, 2, 'scarico', 100]); // nave_id = 1, prodotto_id = 2, 100 pezzi scaricati

echo "<script>
alert('Scarico effettuato');
window.location.href = 'index.php';
</script>";
?>