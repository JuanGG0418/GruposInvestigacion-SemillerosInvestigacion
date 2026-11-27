<?php

$conexion = new mysqli("sql106.infinityfree.com", "if0_42524756", "Cocomusa1224", "if0_42524756_investigacionud",3306);

if ($conexion->connect_error) {
    echo "Error en la conexion";
    die("Error de conexión: " . $conexion->connect_error);
}

?>