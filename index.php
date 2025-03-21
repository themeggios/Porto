<?php
require "db.php";

echo "ID necessario per simulare: " . $id;

?>

<hmtl>
    <head>
    <title>Porto</title>
    </head>
<body>

    <h1>⚓ Porto Commerciale "Mare Nostrum"</h1>

    <div class="btn-container">
    
        <a href="arrivo.php" class="btn">Operazione Arrivo</a><br><br>
        <a href="scarico.php" class="btn">Operazione Scarico</a><br><br>
        <a href="carico.php" class="btn">Operazione Carico</a><br><br>
        <a href="partenza.php" class="btn">Operazione Partenza</a><br><br>

    </div>

</body>
</html>