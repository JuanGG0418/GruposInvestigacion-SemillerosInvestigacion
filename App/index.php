<?php
include('conexion.php');
include('funciones.php');

// Cerrar sesión
if (isset($_GET['logout'])) {
    session_unset();
    session_destroy();
    header("Location: login.php");
    exit;
}

$alerta = null;

// Procesar creaciones según formulario enviado
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion'])) {
    switch ($_POST['accion']) {
        case 'crear_proyecto':
            $cedProf = !empty($_POST['cedula_profesor']) ? (int)$_POST['cedula_profesor'] : null;
            $alerta = crearProyectos(
                $conexion,
                trim($_POST['nombre']),
                (int)$_POST['codigo'],
                (float)$_POST['valor_presupuesto'],
                $_POST['fecha_inicio'],
                $_POST['fecha_fin'],
                $_POST['nombre_grupo_investigacion'],
                $cedProf,
                (int)($_POST['dedicacion'] ?? 10)
            );
            break;

        case 'crear_facultad':
            $tel = !empty($_POST['telefono']) ? (int)$_POST['telefono'] : null;
            $alerta = crearFacultad(
                $conexion,
                trim($_POST['nombre']),
                (int)$_POST['cod_sede'],
                (int)$_POST['cedula_profesor'],
                $tel
            );
            break;

        case 'crear_grupo':
            $alerta = crearGrupoInvestigación(
                $conexion,
                trim($_POST['nombre']),
                (int)$_POST['codigo'],
                (int)$_POST['cod_area_interes'],
                (int)$_POST['cedula_profesor'],
                $_POST['nombre_facultad']
            );
            break;

        case 'crear_profesor':
            $alerta = crearProfesores(
                $conexion,
                (int)$_POST['cedula'],
                trim($_POST['nombre']),
                (int)$_POST['anios_expe_inve'],
                $_POST['titulo'] ?? null
            );
            break;

        case 'crear_area':
            $alerta = crearAreaInteres(
                $conexion,
                (int)$_POST['codigo'],
                trim($_POST['area_interes'])
            );
            break;

        case 'crear_sede':
            $alerta = crearSede(
                $conexion,
                (int)$_POST['codigo'],
                trim($_POST['sede'])
            );
            break;
    }
}

// Datos directos de $_SESSION
$rol      = $_SESSION['rol'] ?? 'invitado';
$nombre   = $_SESSION['nombre'] ?? 'Visitante';
$facultad = $_SESSION['facultad'] ?? null;

// Filtros de búsqueda específica (Todos o uno en específico)
$filtroProyecto = $_GET['q_proyecto'] ?? null;
$filtroFacultad = $_GET['q_facultad'] ?? null;
$filtroGrupo    = $_GET['q_grupo'] ?? null;
$filtroProfesor = $_GET['q_profesor'] ?? null;

// Consultas permitidas
$proyectos  = verProyectos($conexion, $filtroProyecto);
$facultades = verFacultades($conexion, $filtroFacultad);
$grupos     = verGruposInvestigación($conexion, $filtroGrupo);
$profesores = tienePermiso(['decano', 'admin']) ? verProfesores($conexion, $filtroProfesor) : [];

$sedes = verSedes($conexion);
$areas = verAreasInteres($conexion);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Investigación UD - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background-color: #C5DBFF; }
        .card-dashboard { border: none; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.php">
            <i class="bi bi-journal-bookmark-fill me-2"></i>Investigación UD
        </a>
        <div class="d-flex align-items-center gap-3">
            <span class="badge bg-light text-primary fs-6">
                <i class="bi bi-person-circle me-1"></i>
                <?= htmlspecialchars($nombre) ?> — <?= strtoupper($rol) ?>
                <?= $facultad ? ' | ' . htmlspecialchars($facultad) : '' ?>
            </span>
            <?php if ($rol === 'invitado'): ?>
                <a href="login.php" class="btn btn-outline-light btn-sm">Iniciar Sesión</a>
            <?php else: ?>
                <a href="?logout=1" class="btn btn-danger btn-sm">Cerrar Sesión</a>
            <?php endif; ?>
        </div>
    </div>
</nav>

<div class="container pb-5">

    <?php if ($alerta): ?>
        <div class="alert alert-<?= $alerta['ok'] ? 'success' : 'danger' ?> alert-dismissible fade show">
            <?= htmlspecialchars($alerta['mensaje']) ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <?php endif; ?>

    <!-- Tarjetas de resumen -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card card-dashboard p-3">
                <small class="text-muted">Proyectos</small>
                <h3 class="fw-bold mb-0"><?= count($proyectos) ?></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-dashboard p-3">
                <small class="text-muted">Grupos de Investigación</small>
                <h3 class="fw-bold mb-0"><?= count($grupos) ?></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card card-dashboard p-3">
                <small class="text-muted">Facultades</small>
                <h3 class="fw-bold mb-0"><?= count($facultades) ?></h3>
            </div>
        </div>
        <?php if (tienePermiso(['decano', 'admin'])): ?>
        <div class="col-md-3">
            <div class="card card-dashboard p-3">
                <small class="text-muted">Profesores</small>
                <h3 class="fw-bold mb-0"><?= count($profesores) ?></h3>
            </div>
        </div>
        <?php endif; ?>
    </div>

<!-- Botones de creación según matriz de roles -->
    <?php if (tienePermiso(['profesor', 'decano', 'admin'])): ?>
    <div class="card card-dashboard p-3 mb-4">
        <div class="d-flex flex-wrap gap-2 align-items-center">
            <span class="fw-semibold me-2"><i class="bi bi-plus-square-fill text-primary"></i> Gestión:</span>

            <?php if (tienePermiso(['profesor', 'decano', 'admin'])): ?>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalProyecto">
                    + Crear Proyecto
                </button>
            <?php endif; ?>

            <?php if (tienePermiso(['profesor', 'decano', 'admin'])): ?>
                <button class="btn btn-info btn-sm text-white" data-bs-toggle="modal" data-bs-target="#modalArea">
                    + Crear Área de Interés
                </button>
            <?php endif; ?>

            <?php if (tienePermiso(['profesor', 'decano', 'admin'])): ?>
                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalGrupo">
                    + Crear Grupo Investigación
                </button>
            <?php endif; ?>

            <?php if (tienePermiso(['decano', 'admin'])): ?>
                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalProfesor">
                    + Crear Profesor
                </button>
            <?php endif; ?>

            <?php if (tienePermiso(['admin'])): ?>
                <button class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#modalFacultad">
                    + Crear Facultad
                </button>
            <?php endif; ?>

            <?php if (tienePermiso(['admin'])): ?>
                <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalSede">
                    + Crear Sede
                </button>
            <?php endif; ?>
        </div>
    </div>
    <?php endif; ?>

    <!-- Pestañas -->
    <ul class="nav nav-pills mb-3" role="tablist">
        <li class="nav-item"><button class="nav-link active" data-bs-toggle="pill" data-bs-target="#tab-proyectos">Proyectos</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-grupos">Grupos</button></li>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-facultades">Facultades</button></li>
        <?php if (tienePermiso(['decano', 'admin'])): ?>
        <li class="nav-item"><button class="nav-link" data-bs-toggle="pill" data-bs-target="#tab-profesores">Profesores</button></li>
        <?php endif; ?>
    </ul>

    <div class="tab-content">
        <!-- PROYECTOS -->
        <div class="tab-pane fade show active" id="tab-proyectos">
            <div class="card card-dashboard p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Proyectos de Investigación</h5>
                    <form method="GET" class="d-flex gap-2">
                        <input type="text" name="q_proyecto" class="form-control form-control-sm" placeholder="Nombre o código..." value="<?= htmlspecialchars($filtroProyecto ?? '') ?>">
                        <button class="btn btn-sm btn-outline-primary">Buscar</button>
                        <?php if ($filtroProyecto): ?><a href="index.php" class="btn btn-sm btn-outline-secondary">Todos</a><?php endif; ?>
                    </form>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Cód.</th>
                                <th>Proyecto</th>
                                <th>Grupo / Facultad</th>
                                <th>Presupuesto</th>
                                <th>Fechas</th>
                                <th>Participantes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($proyectos as $p): ?>
                            <tr>
                                <td><?= $p['codigo'] ?></td>
                                <td><strong><?= htmlspecialchars($p['nombre']) ?></strong></td>
                                <td>
                                    <?= htmlspecialchars($p['nombre_grupo_investigacion']) ?><br>
                                    <small class="text-muted"><?= htmlspecialchars($p['nombre_facultad']) ?></small>
                                </td>
                                <td>$<?= number_format((float)$p['valor_presupuesto'], 0, ',', '.') ?></td>
                                <td><small><?= $p['fecha_inicio'] ?> al <?= $p['fecha_fin'] ?></small></td>
                                <td>
                                    <small><strong>Prof:</strong> <?= htmlspecialchars($p['profesores'] ?? '-') ?></small><br>
                                    <small><strong>Est:</strong> <?= htmlspecialchars($p['estudiantes'] ?? '-') ?></small>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- GRUPOS -->
        <div class="tab-pane fade" id="tab-grupos">
            <div class="card card-dashboard p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Grupos de Investigación</h5>
                    <form method="GET" class="d-flex gap-2">
                        <input type="text" name="q_grupo" class="form-control form-control-sm" placeholder="Nombre o código..." value="<?= htmlspecialchars($filtroGrupo ?? '') ?>">
                        <button class="btn btn-sm btn-outline-primary">Buscar</button>
                    </form>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Cód.</th>
                                <th>Grupo</th>
                                <th>Área de Interés</th>
                                <th>Facultad</th>
                                <th>Líder</th>
                                <th>Colaboradores</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($grupos as $g): ?>
                            <tr>
                                <td><?= $g['codigo'] ?></td>
                                <td><strong><?= htmlspecialchars($g['nombre']) ?></strong></td>
                                <td><?= htmlspecialchars($g['area_interes']) ?></td>
                                <td><?= htmlspecialchars($g['nombre_facultad']) ?></td>
                                <td><?= htmlspecialchars($g['nombre_lider'] ?? '-') ?></td>
                                <td><small><?= htmlspecialchars($g['colaboradores'] ?? '-') ?></small></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- FACULTADES -->
        <div class="tab-pane fade" id="tab-facultades">
            <div class="card card-dashboard p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Facultades</h5>
                    <form method="GET" class="d-flex gap-2">
                        <input type="text" name="q_facultad" class="form-control form-control-sm" placeholder="Nombre facultad..." value="<?= htmlspecialchars($filtroFacultad ?? '') ?>">
                        <button class="btn btn-sm btn-outline-primary">Buscar</button>
                    </form>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Facultad</th>
                                <th>Sede</th>
                                <th>Decano</th>
                                <th>Teléfonos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($facultades as $f): ?>
                            <tr>
                                <td><strong><?= htmlspecialchars($f['nombre']) ?></strong></td>
                                <td><?= htmlspecialchars($f['nombre_sede']) ?></td>
                                <td><?= htmlspecialchars($f['nombre_decano'] ?? '-') ?></td>
                                <td><?= htmlspecialchars($f['telefonos'] ?? '-') ?></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- PROFESORES (Solo Decano y Admin) -->
        <?php if (tienePermiso(['decano', 'admin'])): ?>
        <div class="tab-pane fade" id="tab-profesores">
            <div class="card card-dashboard p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Profesores Investigadores</h5>
                    <form method="GET" class="d-flex gap-2">
                        <input type="text" name="q_profesor" class="form-control form-control-sm" placeholder="Nombre o cédula..." value="<?= htmlspecialchars($filtroProfesor ?? '') ?>">
                        <button class="btn btn-sm btn-outline-primary">Buscar</button>
                    </form>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Cédula</th>
                                <th>Nombre</th>
                                <th>Años Exp.</th>
                                <th>Títulos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($profesores as $pr): ?>
                            <tr>
                                <td><?= $pr['cedula'] ?></td>
                                <td><strong><?= htmlspecialchars($pr['nombre']) ?></strong></td>
                                <td><?= $pr['anios_expe_inve'] ?> años</td>
                                <td><small><?= htmlspecialchars($pr['titulos'] ?? '-') ?></small></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <?php endif; ?>
    </div>
</div>

<!-- MODAL CREAR PROYECTO -->
<?php if (tienePermiso(['profesor', 'lider', 'decano', 'admin'])): ?>
<div class="modal fade" id="modalProyecto" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_proyecto">
            <div class="modal-header"><h5 class="modal-title">Crear Proyecto</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="mb-2"><label class="form-label">Nombre del Proyecto</label><input type="text" name="nombre" class="form-control" required></div>
                <div class="row">
                    <div class="col-md-6 mb-2"><label class="form-label">Código</label><input type="number" name="codigo" class="form-control" required></div>
                    <div class="col-md-6 mb-2"><label class="form-label">Presupuesto ($)</label><input type="number" step="0.01" name="valor_presupuesto" class="form-control" required></div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-2"><label class="form-label">Fecha Inicio</label><input type="date" name="fecha_inicio" class="form-control" required></div>
                    <div class="col-md-6 mb-2"><label class="form-label">Fecha Fin</label><input type="date" name="fecha_fin" class="form-control" required></div>
                </div>
                <div class="mb-2">
                    <label class="form-label">Grupo de Investigación</label>
                    <select name="nombre_grupo_investigacion" class="form-select" required>
                        <?php foreach ($grupos as $g): ?>
                            <option value="<?= htmlspecialchars($g['nombre']) ?>"><?= htmlspecialchars($g['nombre']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="row">
                    <div class="col-md-8 mb-2">
                        <label class="form-label">Cédula Profesor Responsable</label>
                        <input type="number" name="cedula_profesor" class="form-control" value="<?= $_SESSION['cedula_profesor'] ?? '' ?>">
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="form-label">Dedicación (h)</label>
                        <input type="number" name="dedicacion" class="form-control" value="15">
                    </div>
                </div>
            </div>
            <div class="modal-footer"><button type="submit" class="btn btn-primary">Guardar Proyecto</button></div>
        </form>
    </div>
</div>
<?php endif; ?>

<!-- MODAL CREAR GRUPO -->
<?php if (tienePermiso(['lider', 'decano', 'admin'])): ?>
<div class="modal fade" id="modalGrupo" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_grupo">
            <div class="modal-header"><h5 class="modal-title">Crear Grupo de Investigación</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="mb-2"><label class="form-label">Nombre del Grupo</label><input type="text" name="nombre" class="form-control" required></div>
                <div class="mb-2"><label class="form-label">Código</label><input type="number" name="codigo" class="form-control" required></div>
                <div class="mb-2">
                    <label class="form-label">Área de Interés</label>
                    <select name="cod_area_interes" class="form-select" required>
                        <?php foreach ($areas as $a): ?>
                            <option value="<?= $a['codigo'] ?>"><?= htmlspecialchars($a['area_interes']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label">Facultad</label>
                    <select name="nombre_facultad" class="form-select" required>
                        <?php foreach ($facultades as $f): ?>
                            <option value="<?= htmlspecialchars($f['nombre']) ?>"><?= htmlspecialchars($f['nombre']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label">Cédula Profesor Líder</label>
                    <input type="number" name="cedula_profesor" class="form-control" value="<?= $_SESSION['cedula_profesor'] ?? '' ?>" required>
                </div>
            </div>
            <div class="modal-footer"><button type="submit" class="btn btn-success">Guardar Grupo</button></div>
        </form>
    </div>
</div>
<?php endif; ?>

<!-- MODAL CREAR PROFESOR -->
<?php if (tienePermiso(['decano', 'admin'])): ?>
<div class="modal fade" id="modalProfesor" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_profesor">
            <div class="modal-header"><h5 class="modal-title">Registrar Profesor</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="mb-2"><label class="form-label">Cédula</label><input type="number" name="cedula" class="form-control" required></div>
                <div class="mb-2"><label class="form-label">Nombre Completo</label><input type="text" name="nombre" class="form-control" required></div>
                <div class="mb-2"><label class="form-label">Años de Experiencia</label><input type="number" name="anios_expe_inve" class="form-control" required></div>
                <div class="mb-2"><label class="form-label">Título Académico Principal</label><input type="text" name="titulo" class="form-control" placeholder="Ej: Doctor en Ingeniería"></div>
            </div>
            <div class="modal-footer"><button type="submit" class="btn btn-warning">Guardar Profesor</button></div>
        </form>
    </div>
</div>
<?php endif; ?>

<!-- MODAL CREAR FACULTAD -->
<?php if (tienePermiso(['admin'])): ?>
<div class="modal fade" id="modalFacultad" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_facultad">
            <div class="modal-header"><h5 class="modal-title">Crear Facultad</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">
                <div class="mb-2"><label class="form-label">Nombre de la Facultad</label><input type="text" name="nombre" class="form-control" required></div>
                <div class="mb-2">
                    <label class="form-label">Sede</label>
                    <select name="cod_sede" class="form-select" required>
                        <?php foreach ($sedes as $s): ?>
                            <option value="<?= $s['codigo'] ?>"><?= htmlspecialchars($s['sede']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="mb-2"><label class="form-label">Cédula del Decano</label><input type="number" name="cedula_profesor" class="form-control" required></div>
                <div class="mb-2"><label class="form-label">Teléfono (Opcional)</label><input type="number" name="telefono" class="form-control"></div>
            </div>
            <div class="modal-footer"><button type="submit" class="btn btn-dark">Guardar Facultad</button></div>
        </form>
    </div>
</div>
<?php endif; ?>

<!-- MODAL CREAR ÁREA DE INTERÉS (Profesor, Decano, Admin) -->
<?php if (tienePermiso(['profesor', 'decano', 'admin'])): ?>
<div class="modal fade" id="modalArea" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_area">
            <div class="modal-header">
                <h5 class="modal-title">Crear Área de Interés</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-2">
                    <label class="form-label">Código</label>
                    <input type="number" name="codigo" class="form-control" placeholder="Ej: 21" required>
                </div>
                <div class="mb-2">
                    <label class="form-label">Nombre del Área de Interés</label>
                    <input type="text" name="area_interes" class="form-control" placeholder="Ej: Computación en la Nube" required>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info text-white">Guardar Área</button>
            </div>
        </form>
    </div>
</div>
<?php endif; ?>

<!-- MODAL CREAR SEDE (Admin) -->
<?php if (tienePermiso(['admin'])): ?>
<div class="modal fade" id="modalSede" tabindex="-1">
    <div class="modal-dialog">
        <form method="POST" class="modal-content">
            <input type="hidden" name="accion" value="crear_sede">
            <div class="modal-header">
                <h5 class="modal-title">Crear Sede</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-2">
                    <label class="form-label">Código de Sede</label>
                    <input type="number" name="codigo" class="form-control" placeholder="Ej: 21" required>
                </div>
                <div class="mb-2">
                    <label class="form-label">Nombre de la Sede</label>
                    <input type="text" name="sede" class="form-control" placeholder="Ej: Sede Macarena" required>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-secondary">Guardar Sede</button>
            </div>
        </form>
    </div>
</div>
<?php endif; ?>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>