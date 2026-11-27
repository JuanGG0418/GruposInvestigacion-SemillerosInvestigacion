<?php
    include('conexion.php');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Investigacion UD</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
  <section class="col-12 col-lg-il-7 d-flex align-items-center justify-content-center p-4">
    <div class="form-ancho">

      <h1 class="mb-2">Inicia sesión</h1>
      <p class="text-secondary mb-4">Docentes, estudiantes y decanos entran aquí. Cada quien ve solo lo que le corresponde.</p>

      <form method="post" action="">
        <label for="Usuario" class="form-label">Usuario</label>
        <input type="email" id="correo" name="correo" class="form-control mb-3" placeholder="nombre@correo.com"

        <label for="clave" class="form-label">Contraseña</label>
        <input type="password" id="clave" name="clave" class="form-control mb-3" placeholder="12345678" required>

        <div class="d-flex justify-content-between align-items-center mb-3">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="mantener" name="mantener" value="1" checked>
            <label class="form-check-label text-secondary" for="mantener">Mantener sesión</label>
          </div>
        </div>

        <button type="submit" class="btn btn-primary w-100">Entrar</button>
      </form>

    </div>
  </section>
</div>
</body>
</html>