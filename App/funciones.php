<?php
session_start();

function tienePermiso(array $rolesPermitidos): bool {
    $rolActual = $_SESSION['rol'] ?? 'invitado';
    return in_array($rolActual, $rolesPermitidos, true);
}

// 1. LOGIN (Todos) - Carga toda la info en $_SESSION en una sola consulta
function login(mysqli $conexion, string $usuarioInput, string $clave): array {
    // 1. Consulta básica únicamente a la tabla usuarios
    $sql = "SELECT id, usuario, password, rol, codigo_estudiante, cedula_profesor 
            FROM usuarios 
            WHERE usuario = ? AND Activo = 'S' 
            LIMIT 1";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("s", $usuarioInput);
    $stmt->execute();
    $user = $stmt->get_result()->fetch_assoc();

    // Si no existe o la clave no coincide, salimos de inmediato
    if (!$user || !password_verify($clave, $user['password'])) {
        return ['ok' => false, 'mensaje' => 'Usuario o contraseña incorrectos.'];
    }

    // Valores por defecto en sesión
    $nombre   = 'Administrador';
    $facultad = null;
    $rol      = strtolower($user['rol']);

    // 2. Si es estudiante, consulta directa por llave primaria
    if (!empty($user['codigo_estudiante'])) {
        $cod = (int)$user['codigo_estudiante'];
        $est = $conexion->query("SELECT nombre, nombre_facultad FROM estudiante WHERE codigo = $cod")->fetch_assoc();
        if ($est) {
            $nombre   = $est['nombre'];
            $facultad = $est['nombre_facultad'];
        }
    }

    // 3. Si es profesor o decano, consulta directa por llave primaria
    if (!empty($user['cedula_profesor'])) {
        $ced = (int)$user['cedula_profesor'];
        $prof = $conexion->query("SELECT nombre FROM profesor WHERE cedula = $ced")->fetch_assoc();
        if ($prof) {
            $nombre = $prof['nombre'];
        }

        // Si es decano, buscamos qué facultad dirige
        if ($rol === 'decano') {
            $fac = $conexion->query("SELECT nombre FROM facultad WHERE cedula_profesor = $ced LIMIT 1")->fetch_assoc();
            $facultad = $fac['nombre'] ?? null;
        }
    }

    // Guardamos todo en $_SESSION
    $_SESSION['logueado']          = true;
    $_SESSION['id_usuario']        = $user['id'];
    $_SESSION['usuario']           = $user['usuario'];
    $_SESSION['nombre']            = $nombre;
    $_SESSION['rol']               = $rol;
    $_SESSION['codigo_estudiante'] = $user['codigo_estudiante'];
    $_SESSION['cedula_profesor']   = $user['cedula_profesor'];
    $_SESSION['facultad']          = $facultad;

    return ['ok' => true, 'mensaje' => "Bienvenido, $nombre"];
}

// 2. VER PROYECTOS (Todos) - Todos o uno específico por nombre o código
function verProyectos(mysqli $conexion, ?string $filtro = null): array {
    $sql = "SELECT p.nombre, p.codigo, p.valor_presupuesto, p.fecha_inicio, p.fecha_fin,
                   p.nombre_grupo_investigacion, g.nombre_facultad
            FROM proyecto p
            INNER JOIN grupo_investigacion g ON p.nombre_grupo_investigacion = g.nombre";

    if ($filtro !== null && trim($filtro) !== '') {
        $sql .= " WHERE p.nombre LIKE ? OR p.codigo = ? ORDER BY p.codigo ASC";
        $stmt = $conexion->prepare($sql);
        $like = "%$filtro%";
        $codInt = is_numeric($filtro) ? (int)$filtro : -1;
        $stmt->bind_param("si", $like, $codInt);
        $stmt->execute();
        $proyectos = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    } else {
        $sql .= " ORDER BY p.codigo ASC";
        $proyectos = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    // Agregamos profesores y estudiantes con consultas simples de 2 tablas por cada proyecto
    foreach ($proyectos as &$p) {
        $nombreProy = $conexion->real_escape_string($p['nombre']);

        // Profesores del proyecto
        $resProf = $conexion->query("SELECT pr.nombre, pa.dedicacion 
                                     FROM participar pa 
                                     INNER JOIN profesor pr ON pa.cedula_profesor = pr.cedula 
                                     WHERE pa.nombre_proyecto = '$nombreProy'");
        $listaProf = [];
        while ($row = $resProf->fetch_assoc()) {
            $listaProf[] = $row['nombre'] . ' (' . $row['dedicacion'] . 'h)';
        }
        $p['profesores'] = implode(', ', $listaProf);

        // Estudiantes del proyecto
        $resEst = $conexion->query("SELECT e.nombre 
                                    FROM conformar c 
                                    INNER JOIN estudiante e ON c.codigo_estudiante = e.codigo 
                                    WHERE c.nombre_proyecto = '$nombreProy'");
        $listaEst = [];
        while ($row = $resEst->fetch_assoc()) {
            $listaEst[] = $row['nombre'];
        }
        $p['estudiantes'] = implode(', ', $listaEst);
    }

    return $proyectos;
}

// 3. VER FACULTADES (Todos) - Todas o una específica por nombre
function verFacultades(mysqli $conexion, ?string $nombre = null): array {
    $sql = "SELECT f.nombre, f.cod_sede, s.sede AS nombre_sede,
                   f.cedula_profesor, p.nombre AS nombre_decano
            FROM facultad f
            INNER JOIN sede s ON f.cod_sede = s.codigo
            LEFT JOIN profesor p ON f.cedula_profesor = p.cedula";

    if ($nombre !== null && trim($nombre) !== '') {
        $sql .= " WHERE f.nombre LIKE ? ORDER BY f.nombre ASC";
        $stmt = $conexion->prepare($sql);
        $like = "%$nombre%";
        $stmt->bind_param("s", $like);
        $stmt->execute();
        $facultades = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    } else {
        $sql .= " ORDER BY f.nombre ASC";
        $facultades = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    // Agregamos los teléfonos de cada facultad con una consulta simple de 1 tabla
    foreach ($facultades as &$f) {
        $nombreFac = $conexion->real_escape_string($f['nombre']);
        $resTel = $conexion->query("SELECT telefono FROM telefono_facultad WHERE nombre = '$nombreFac'");
        
        $telefonos = [];
        while ($row = $resTel->fetch_assoc()) {
            $telefonos[] = $row['telefono'];
        }
        $f['telefonos'] = implode(' / ', $telefonos);
    }

    return $facultades;
}

// 4. VER GRUPOS DE INVESTIGACIÓN (Todos) - Todos o uno específico por nombre o código
function verGruposInvestigación(mysqli $conexion, ?string $filtro = null): array {
    $sql = "SELECT g.nombre, g.codigo, g.cod_area_interes, a.area_interes,
                   g.cedula_profesor, p.nombre AS nombre_lider, g.nombre_facultad
            FROM grupo_investigacion g
            INNER JOIN areai a ON g.cod_area_interes = a.codigo
            LEFT JOIN profesor p ON g.cedula_profesor = p.cedula";

    if ($filtro !== null && trim($filtro) !== '') {
        $sql .= " WHERE g.nombre LIKE ? OR g.codigo = ? ORDER BY g.codigo ASC";
        $stmt = $conexion->prepare($sql);
        $like = "%$filtro%";
        $codInt = is_numeric($filtro) ? (int)$filtro : -1;
        $stmt->bind_param("si", $like, $codInt);
        $stmt->execute();
        $grupos = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    } else {
        $sql .= " ORDER BY g.codigo ASC";
        $grupos = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    // Agregamos los profesores colaboradores con una consulta simple de 2 tablas
    foreach ($grupos as &$g) {
        $nombreGrupo = $conexion->real_escape_string($g['nombre']);
        $resCol = $conexion->query("SELECT pr.nombre 
                                    FROM colaborar col 
                                    INNER JOIN profesor pr ON col.cedula_profesor = pr.cedula 
                                    WHERE col.nombre_grupo_investigacion = '$nombreGrupo'");
        $colaboradores = [];
        while ($row = $resCol->fetch_assoc()) {
            $colaboradores[] = $row['nombre'];
        }
        $g['colaboradores'] = implode(', ', $colaboradores);
    }

    return $grupos;
}

// 5. VER PROFESORES (Decano, Admin) - Todos o uno específico por cédula o nombre
function verProfesores(mysqli $conexion, ?string $filtro = null): array {
    if (!tienePermiso(['decano', 'admin'])) {
        return [];
    }

    $sql = "SELECT cedula, nombre, anios_expe_inve FROM profesor";

    if ($filtro !== null && trim($filtro) !== '') {
        $sql .= " WHERE nombre LIKE ? OR cedula = ? ORDER BY nombre ASC";
        $stmt = $conexion->prepare($sql);
        $like = "%$filtro%";
        $cedInt = is_numeric($filtro) ? (int)$filtro : -1;
        $stmt->bind_param("si", $like, $cedInt);
        $stmt->execute();
        $profesores = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    } else {
        $sql .= " ORDER BY nombre ASC";
        $profesores = $conexion->query($sql)->fetch_all(MYSQLI_ASSOC);
    }

    // Agregamos los títulos de cada profesor con un SELECT simple de 1 tabla
    foreach ($profesores as &$pr) {
        $ced = (int)$pr['cedula'];
        $resTit = $conexion->query("SELECT titulo FROM titulo_profesor WHERE cedula = $ced");
        
        $titulos = [];
        while ($row = $resTit->fetch_assoc()) {
            $titulos[] = $row['titulo'];
        }
        $pr['titulos'] = implode(' | ', $titulos);
    }

    return $profesores;
}

// 6. CREAR PROYECTOS (Profesor, Líder, Decano, Admin)
function crearProyectos(mysqli $conexion, string $nombre, int $codigo, float $presupuesto, string $fechaInicio, string $fechaFin, string $nombreGrupo, ?int $cedulaProfesor = null, int $dedicacion = 10): array {
    if (!tienePermiso(['profesor', 'lider', 'decano', 'admin'])) {
        return ['ok' => false, 'mensaje' => 'No tienes permisos para crear proyectos.'];
    }

    $sql = "INSERT INTO proyecto (nombre, codigo, valor_presupuesto, fecha_inicio, fecha_fin, nombre_grupo_investigacion)
            VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("sidsss", $nombre, $codigo, $presupuesto, $fechaInicio, $fechaFin, $nombreGrupo);

    if ($stmt->execute()) {
        if ($cedulaProfesor !== null && $cedulaProfesor > 0) {
            $stmtPart = $conexion->prepare("INSERT INTO participar (nombre_proyecto, cedula_profesor, fecha_incorporacion, dedicacion) VALUES (?, ?, ?, ?)");
            $stmtPart->bind_param("sisi", $nombre, $cedulaProfesor, $fechaInicio, $dedicacion);
            $stmtPart->execute();
        }
        return ['ok' => true, 'mensaje' => "Proyecto '$nombre' creado correctamente."];
    }
    return ['ok' => false, 'mensaje' => 'Error al crear proyecto: ' . $conexion->error];
}

// 7. CREAR FACULTAD (Admin)
function crearFacultad(mysqli $conexion, string $nombre, int $codSede, int $cedulaDecano, ?int $telefono = null): array {
    if (!tienePermiso(['admin'])) {
        return ['ok' => false, 'mensaje' => 'Solo el Administrador puede crear facultades.'];
    }

    $sql = "INSERT INTO facultad (nombre, cod_sede, cedula_profesor) VALUES (?, ?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("sii", $nombre, $codSede, $cedulaDecano);

    if ($stmt->execute()) {
        if ($telefono !== null && $telefono > 0) {
            $stmtTel = $conexion->prepare("INSERT INTO telefono_facultad (nombre, telefono) VALUES (?, ?)");
            $stmtTel->bind_param("si", $nombre, $telefono);
            $stmtTel->execute();
        }
        return ['ok' => true, 'mensaje' => "Facultad '$nombre' creada correctamente."];
    }
    return ['ok' => false, 'mensaje' => 'Error al crear facultad: ' . $conexion->error];
}

// 8. CREAR GRUPO DE INVESTIGACIÓN (Líder, Decano, Admin)
function crearGrupoInvestigación(mysqli $conexion, string $nombre, int $codigo, int $codAreaInteres, int $cedulaLider, string $nombreFacultad): array {
    if (!tienePermiso(['lider', 'decano', 'admin'])) {
        return ['ok' => false, 'mensaje' => 'No tienes permisos para crear grupos de investigación.'];
    }

    $sql = "INSERT INTO grupo_investigacion (nombre, codigo, cod_area_interes, cedula_profesor, nombre_facultad)
            VALUES (?, ?, ?, ?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("siiis", $nombre, $codigo, $codAreaInteres, $cedulaLider, $nombreFacultad);

    return $stmt->execute()
        ? ['ok' => true, 'mensaje' => "Grupo '$nombre' creado correctamente."]
        : ['ok' => false, 'mensaje' => 'Error al crear grupo: ' . $conexion->error];
}

// 9. CREAR PROFESORES (Decano, Admin)
function crearProfesores(mysqli $conexion, int $cedula, string $nombre, int $aniosExperiencia, ?string $titulo = null): array {
    if (!tienePermiso(['decano', 'admin'])) {
        return ['ok' => false, 'mensaje' => 'No tienes permisos para registrar profesores.'];
    }

    $sql = "INSERT INTO profesor (cedula, nombre, anios_expe_inve) VALUES (?, ?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("isi", $cedula, $nombre, $aniosExperiencia);

    if ($stmt->execute()) {
        if ($titulo !== null && trim($titulo) !== '') {
            $stmtTit = $conexion->prepare("INSERT INTO titulo_profesor (titulo, cedula) VALUES (?, ?)");
            $stmtTit->bind_param("si", $titulo, $cedula);
            $stmtTit->execute();
        }
        return ['ok' => true, 'mensaje' => "Profesor '$nombre' registrado correctamente."];
    }
    return ['ok' => false, 'mensaje' => 'Error al registrar profesor: ' . $conexion->error];
}

// 10. VER ÁREAS DE INTERÉS (Todos)
function verAreasInteres(mysqli $conexion): array {
    return $conexion->query("SELECT codigo, area_interes FROM areai ORDER BY codigo ASC")->fetch_all(MYSQLI_ASSOC);
}

// 11. CREAR ÁREA DE INTERÉS (Profesor, Decano, Admin)
function crearAreaInteres(mysqli $conexion, int $codigo, string $areaInteres): array {
    if (!tienePermiso(['profesor', 'decano', 'admin'])) {
        return ['ok' => false, 'mensaje' => 'No tienes permisos para crear áreas de interés.'];
    }

    $sql = "INSERT INTO areai (codigo, area_interes) VALUES (?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("is", $codigo, $areaInteres);

    return $stmt->execute()
        ? ['ok' => true, 'mensaje' => "Área de interés '$areaInteres' creada correctamente."]
        : ['ok' => false, 'mensaje' => 'Error al crear área de interés (verifica que el código no exista): ' . $conexion->error];
}

// 12. VER SEDES (Todos)
function verSedes(mysqli $conexion): array {
    return $conexion->query("SELECT codigo, sede FROM sede ORDER BY codigo ASC")->fetch_all(MYSQLI_ASSOC);
}

// 13. CREAR SEDE (Admin)
function crearSede(mysqli $conexion, int $codigo, string $sede): array {
    if (!tienePermiso(['admin'])) {
        return ['ok' => false, 'mensaje' => 'Solo el Administrador puede crear sedes.'];
    }

    $sql = "INSERT INTO sede (codigo, sede) VALUES (?, ?)";
    $stmt = $conexion->prepare($sql);
    $stmt->bind_param("is", $codigo, $sede);

    return $stmt->execute()
        ? ['ok' => true, 'mensaje' => "Sede '$sede' creada correctamente."]
        : ['ok' => false, 'mensaje' => 'Error al crear sede (verifica que el código no exista): ' . $conexion->error];
}