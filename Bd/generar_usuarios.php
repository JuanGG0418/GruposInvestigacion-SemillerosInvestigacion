
<?php

$clave = 'Cambio123!';

echo "<h2>Hashes para usuarios</h2>";

echo "<pre>";
echo "Hash: " . password_hash($clave, PASSWORD_DEFAULT);
echo "</pre>";

?>
