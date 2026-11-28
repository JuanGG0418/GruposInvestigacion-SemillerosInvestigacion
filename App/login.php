<?php
include('conexion.php');
include('funciones.php');

// Si ya tiene sesión activa, va directo al dashboard
if (!empty($_SESSION['logueado'])) {
    header("Location: index.php");
    exit;
}

$error = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario = trim($_POST['usuario'] ?? '');
    $clave   = $_POST['clave'] ?? '';

    $res = login($conexion, $usuario, $clave);
    if ($res['ok']) {
        header("Location: index.php");
        exit;
    } else {
        $error = $res['mensaje'];
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Investigación UD - Login</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
  <section class="col-12 col-lg-7 d-flex align-items-center justify-content-center p-4 mx-auto min-vh-100">
    <div class="form-ancho w-100" style="max-width: 420px;">

      <h1 class="mb-2">Inicia sesión</h1>
      <p class="text-secondary mb-4">Docentes, estudiantes y decanos entran aquí. Cada quien ve solo lo que le corresponde.</p>

      <?php if ($error): ?>
        <div class="alert alert-danger py-2"><?= htmlspecialchars($error) ?></div>
      <?php endif; ?>

      <form method="post" action="">
        <label for="usuario" class="form-label">Usuario (Código o Cédula)</label>
        <input type="text" id="usuario" name="usuario" class="form-control mb-3" placeholder="Ej: 101001 o 20261006" required>

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

      <div class="text-center mt-3">
        <a href="index.php" class="text-decoration-none small">Entrar como visitante (solo lectura)</a>
      </div>

    </div>
  </section>
</body>
</html>