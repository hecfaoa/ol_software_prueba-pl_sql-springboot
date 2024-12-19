

											/* RETO 1 */
											
/*DIAGRAMA ENTIDAD RELACION*/

+-----------------------+            +-----------------------+
|   Comerciante         |            |    Establecimiento    |
+-----------------------+            +-----------------------+
| id_comerciante        |1_____      | id_establecimiento    |
| nombre                |      |     | nombre_establecimiento|
| departamento          |      |     | ingresos              |
| municipio             |      |     | numero_empleados      |
| telefono              |      |____*| id_comerciante (FK)   |
| correo_electronico    |            | fecha_actualizacion   |
| fecha_registro        |            | usuario_actualizacion |
| estado                |            +-----------------------+
| fecha_actualizacion   |
| usuario_actualizacion |
+-----------------------+

/*SCRIPT DE LAS TABLAS*/
										
-- Tabla Comerciante
CREATE TABLE Comerciante (
    id_comerciante NUMBER PRIMARY KEY,
    nombre VARCHAR2(255) NOT NULL,
    departamento VARCHAR2(100) NOT NULL,
    municipio VARCHAR2(100) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    correo_electronico VARCHAR2(255) NOT NULL,
    fecha_registro DATE NOT NULL,
    estado VARCHAR2(20) CHECK (estado IN ('Registrado', 'Activo', 'Inactivo', 'Suspendido', 'Cancelado'));
    fecha_actualizacion DATE,
    usuario_actualizacion VARCHAR2(100)
);

-- Tabla Establecimiento
CREATE TABLE Establecimiento (
    id_establecimiento NUMBER PRIMARY KEY,
    nombre_establecimiento VARCHAR2(255) NOT NULL,
    ingresos NUMBER(10, 2) NOT NULL,
    numero_empleados NUMBER NOT NULL,
    id_comerciante NUMBER NOT NULL,
    fecha_actualizacion DATE,
    usuario_actualizacion VARCHAR2(100);
    CONSTRAINT fk_comerciante
        FOREIGN KEY (id_comerciante)
        REFERENCES Comerciante(id_comerciante)
        ON DELETE CASCADE
);

												/*RETO 2*/
			

-- Secuencia para Comerciante
CREATE SEQUENCE seq_comerciante
START WITH 1
INCREMENT BY 1
NOCACHE;

-- Secuencia para Establecimiento
CREATE SEQUENCE seq_establecimiento
START WITH 1
INCREMENT BY 1
NOCACHE;


--Trigger para la tabla Comerciante
 
CREATE OR REPLACE TRIGGER trg_comerciante
BEFORE INSERT ON Comerciante
FOR EACH ROW
BEGIN
    :NEW.id_comerciante := seq_comerciante.NEXTVAL;
END;
/

--Trigger para la tabla Establecimiento
 
CREATE OR REPLACE TRIGGER trg_establecimiento
BEFORE INSERT ON Establecimiento
FOR EACH ROW
BEGIN
    :NEW.id_establecimiento := seq_establecimiento.NEXTVAL;
END;
/

/*trigger  auditoria comerciante*/
CREATE OR REPLACE TRIGGER trg_comerciante_audit
BEFORE INSERT OR UPDATE ON Comerciante
FOR EACH ROW
BEGIN
    -- Para cada inserción, establecemos la fecha de registro y la fecha de actualización
    IF INSERTING THEN
        :NEW.fecha_registro := SYSDATE; -- Asigna la fecha actual en la inserción
    END IF;
    -- Actualiza la fecha de actualización y el usuario en cada operación de inserción y actualización
    :NEW.fecha_actualizacion := SYSDATE; -- Asigna la fecha actual
    :NEW.usuario_actualizacion := USER; -- Asigna el usuario que realiza la operación
END;

/*trigger auditoria establecimiento*/
CREATE OR REPLACE TRIGGER trg_establecimiento_audit
BEFORE INSERT OR UPDATE ON Establecimiento
FOR EACH ROW
BEGIN
    -- Actualiza la fecha de actualización y el usuario en cada operación de inserción y actualización
    :NEW.fecha_actualizacion := SYSDATE; -- Asigna la fecha actual
    :NEW.usuario_actualizacion := USER; -- Asigna el usuario que realiza la operación
END;



												/*RETO 3*/

/*datos semilla para la entidad Comerciantes */

INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Juan Pérez', 'Antioquia', 'Medellín', '3001234567', 'juan.perez@email.com', SYSDATE, 'Activo');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('María López', 'Cundinamarca', 'Bogotá', '3002345678', 'maria.lopez@email.com', SYSDATE, 'Registrado');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Carlos García', 'Valle del Cauca', 'Cali', '3003456789', 'carlos.garcia@email.com', SYSDATE, 'Inactivo');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Ana Rodríguez', 'Atlántico', 'Barranquilla', '3004567890', 'ana.rodriguez@email.com', SYSDATE, 'Activo');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Luis Martínez', 'Santander', 'Bucaramanga', '3005678901', 'luis.martinez@email.com', SYSDATE, 'Suspendido');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Sofía Torres', 'Bolívar', 'Cartagena', '3006789012', 'sofia.torres@email.com', SYSDATE, 'Cancelado');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Andrés Jiménez', 'Caldas', 'Manizales', '3007890123', 'andres.jimenez@email.com', SYSDATE, 'Activo');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Laura Hernández', 'Cauca', 'Popayán', '3008901234', 'laura.hernandez@email.com', SYSDATE, 'Registrado');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES('Diego Castro', 'Nariño', 'Pasto', '3009012345', 'diego.castro@email.com', SYSDATE, 'Inactivo');
INSERT INTO Comerciante (nombre, departamento, municipio, telefono, correo_electronico, fecha_registro, estado) VALUES( 'Valentina Ruiz', 'Boyacá', 'Tunja', '3000123456', 'valentina.ruiz@email.com', SYSDATE, 'Activo');

/*datos semilla para la entidad Establecimiento */

INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Tienda de Ropa A', 150000.00, 5, 1);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Tienda de Ropa B', 200000.00, 3, 1);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Restaurante A', 300000.00, 10, 2);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Restaurante B', 400000.00, 15, 2);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Supermercado A', 500000.00, 20, 3);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Supermercado B', 600000.00, 25, 3);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Farmacia A', 70000.00, 3, 4);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Farmacia B', 80000.00, 4, 4);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES('Ferretería A', 90000.00, 6, 5);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Ferretería B', 100000.00, 8, 5);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Librería A', 110000.00, 2, 6);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Librería B', 120000.00, 2, 6);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Juguetería A', 130000.00, 5, 7);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Juguetería B', 140000.00, 3, 7);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Panadería A', 150000.00, 4, 8);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Panadería B', 160000.00, 3, 8);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Barbería A', 170000.00, 2, 9);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Barbería B', 180000.00, 2, 9);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Salón de Belleza A', 190000.00, 4, 10);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Salón de Belleza B', 200000.00, 5, 10);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Zapatería A', 210000.00, 3, 1);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Zapatería B', 220000.00, 4, 1);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Restaurante C', 250000.00, 12, 2);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Ferretería C', 270000.00, 6, 3);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Tienda de Electrónica A', 280000.00, 8, 4);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Tienda de Electrónica B', 290000.00, 9, 5);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Tienda de Ropa C', 300000.00, 7, 6);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Restaurante D', 310000.00, 11, 7);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Farmacia C', 32000.00, 2, 8);
INSERT INTO Establecimiento (nombre_establecimiento, ingresos, numero_empleados, id_comerciante) VALUES( 'Supermercado C', 330000.00, 22, 9);



												/*RETO 4*/

CREATE OR REPLACE PACKAGE Comerciante_PKG AS

    -- Estructura de registro para la consulta
    TYPE Comerciante_Record IS RECORD (
        nombre                VARCHAR2(255),
        departamento          VARCHAR2(100),
        municipio             VARCHAR2(100),
        telefono              VARCHAR2(15),
        correo_electronico    VARCHAR2(255),
        fecha_registro        DATE,
        estado                VARCHAR2(20),
        total_activos         NUMBER,
        cantidad_empleados     NUMBER
    );

    -- Funciones para consultar
    FUNCTION consultarPorID(p_id_comerciante IN NUMBER, 
                             p_codigo_error OUT NUMBER, 
                             p_mensaje_error OUT VARCHAR2) RETURN Comerciante_Record;

    FUNCTION consultar(p_nombre IN VARCHAR2 DEFAULT NULL,
                       p_municipio IN VARCHAR2 DEFAULT NULL,
                       p_fecha_registro IN DATE DEFAULT NULL,
                       p_estado IN VARCHAR2 DEFAULT NULL,
                       p_pagina IN NUMBER DEFAULT 1,
                       p_tamano_pagina IN NUMBER DEFAULT 10,
                       p_codigo_error OUT NUMBER,
                       p_mensaje_error OUT VARCHAR2) RETURN SYS_REFCURSOR;

    -- Procedimientos para operaciones CRUD
    PROCEDURE crearComerciante(p_nombre IN VARCHAR2,
                                p_departamento IN VARCHAR2,
                                p_municipio IN VARCHAR2,
                                p_telefono IN VARCHAR2 DEFAULT NULL,
                                p_correo_electronico IN VARCHAR2 DEFAULT NULL,
                                p_fecha_registro IN DATE,
                                p_estado IN VARCHAR2,
                                p_codigo_error OUT NUMBER,
                                p_mensaje_error OUT VARCHAR2);

    PROCEDURE actualizarComerciante(p_id_comerciante IN NUMBER,
                                     p_nombre IN VARCHAR2,
                                     p_departamento IN VARCHAR2,
                                     p_municipio IN VARCHAR2,
                                     p_telefono IN VARCHAR2 DEFAULT NULL,
                                     p_correo_electronico IN VARCHAR2 DEFAULT NULL,
                                     p_fecha_registro IN DATE,
                                     p_estado IN VARCHAR2,
                                     p_codigo_error OUT NUMBER,
                                     p_mensaje_error OUT VARCHAR2);

    PROCEDURE eliminarComerciante(p_id_comerciante IN NUMBER,
                                   p_codigo_error OUT NUMBER,
                                   p_mensaje_error OUT VARCHAR2);

END Comerciante_PKG;
/

CREATE OR REPLACE PACKAGE BODY Comerciante_PKG AS

    -- Función para consultar comerciante por ID
    FUNCTION consultarPorID(p_id_comerciante IN NUMBER, 
                             p_codigo_error OUT NUMBER, 
                             p_mensaje_error OUT VARCHAR2) RETURN Comerciante_Record IS
        v_record Comerciante_Record;
        v_total_activos NUMBER;
        v_cantidad_empleados NUMBER;
    BEGIN
        SELECT c.nombre, c.departamento, c.municipio, c.telefono, 
               c.correo_electronico, c.fecha_registro, c.estado,
               NVL(SUM(e.ingresos), 0) AS total_activos,
               NVL(SUM(e.numero_empleados), 0) AS cantidad_empleados
        INTO v_record.nombre, v_record.departamento, v_record.municipio, 
             v_record.telefono, v_record.correo_electronico, 
             v_record.fecha_registro, v_record.estado,
             v_total_activos, v_cantidad_empleados
        FROM Comerciante c
        LEFT JOIN Establecimiento e ON c.id_comerciante = e.id_comerciante
        WHERE c.id_comerciante = p_id_comerciante
        GROUP BY c.nombre, c.departamento, c.municipio, 
                 c.telefono, c.correo_electronico, 
                 c.fecha_registro, c.estado;

        v_record.total_activos := v_total_activos;
        v_record.cantidad_empleados := v_cantidad_empleados;

        p_codigo_error := 0;
        p_mensaje_error := NULL;

        RETURN v_record;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_codigo_error := 404;
            p_mensaje_error := 'Comerciante no encontrado.';
            RETURN NULL;
        WHEN OTHERS THEN
            p_codigo_error := SQLCODE;
            p_mensaje_error := SQLERRM;
            RETURN NULL;
    END consultarPorID;

    -- Función para consultar con filtros y paginación
    FUNCTION consultar(p_nombre IN VARCHAR2 DEFAULT NULL,
                       p_municipio IN VARCHAR2 DEFAULT NULL,
                       p_fecha_registro IN DATE DEFAULT NULL,
                       p_estado IN VARCHAR2 DEFAULT NULL,
                       p_pagina IN NUMBER DEFAULT 1,
                       p_tamano_pagina IN NUMBER DEFAULT 10,
                       p_codigo_error OUT NUMBER,
                       p_mensaje_error OUT VARCHAR2) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
        v_offset NUMBER := (p_pagina - 1) * p_tamano_pagina;
    BEGIN
        OPEN v_cursor FOR
            SELECT c.nombre, c.departamento, c.municipio, c.telefono, 
                   c.correo_electronico, c.fecha_registro, c.estado,
                   NVL(SUM(e.ingresos), 0) AS total_activos,
                   NVL(SUM(e.numero_empleados), 0) AS cantidad_empleados
            FROM Comerciante c
            LEFT JOIN Establecimiento e ON c.id_comerciante = e.id_comerciante
            WHERE (p_nombre IS NULL OR c.nombre LIKE '%' || p_nombre || '%')
              AND (p_municipio IS NULL OR c.municipio = p_municipio)
              AND (p_fecha_registro IS NULL OR c.fecha_registro = p_fecha_registro)
              AND (p_estado IS NULL OR c.estado = p_estado)
            GROUP BY c.nombre, c.departamento, c.municipio, 
                     c.telefono, c.correo_electronico, 
                     c.fecha_registro, c.estado
            OFFSET v_offset ROWS FETCH NEXT p_tamano_pagina ROWS ONLY;

        p_codigo_error := 0;
        p_mensaje_error := NULL;

        RETURN v_cursor;

    EXCEPTION
        WHEN OTHERS THEN
            p_codigo_error := SQLCODE;
            p_mensaje_error := SQLERRM;
            RETURN NULL;
    END consultar;

    -- Procedimiento para crear comerciante
    PROCEDURE crearComerciante(p_nombre IN VARCHAR2,
                                p_departamento IN VARCHAR2,
                                p_municipio IN VARCHAR2,
                                p_telefono IN VARCHAR2 DEFAULT NULL,
                                p_correo_electronico IN VARCHAR2 DEFAULT NULL,
                                p_fecha_registro IN DATE,
                                p_estado IN VARCHAR2,
                                p_codigo_error OUT NUMBER,
                                p_mensaje_error OUT VARCHAR2) IS
    BEGIN
        -- Validaciones
        IF p_nombre IS NULL OR p_departamento IS NULL OR p_municipio IS NULL OR p_fecha_registro IS NULL OR p_estado IS NULL THEN
            p_codigo_error := 400;
            p_mensaje_error := 'Todos los campos son obligatorios.';
            RETURN;
        END IF;

        IF p_correo_electronico IS NOT NULL AND NOT REGEXP_LIKE(p_correo_electronico, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$') THEN
            p_codigo_error := 400;
            p_mensaje_error := 'El correo electrónico no tiene un formato válido.';
            RETURN;
        END IF;

        INSERT INTO Comerciante (id_comerciante, nombre, departamento, 
                                  municipio, telefono, correo_electronico, 
                                  fecha_registro, estado)
        VALUES (Comerciante_SEQ.NEXTVAL, p_nombre, p_departamento, 
                p_municipio, p_telefono, p_correo_electronico, 
                p_fecha_registro, p_estado);

        p_codigo_error := 0;
        p_mensaje_error := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            p_codigo_error := SQLCODE;
            p_mensaje_error := SQLERRM;
    END crearComerciante;

    -- Procedimiento para actualizar comerciante
    PROCEDURE actualizarComerciante(p_id_comerciante IN NUMBER,
                                     p_nombre IN VARCHAR2,
                                     p_departamento IN VARCHAR2,
                                     p_municipio IN VARCHAR2,
                                     p_telefono IN VARCHAR2 DEFAULT NULL,
                                     p_correo_electronico IN VARCHAR2 DEFAULT NULL,
                                     p_fecha_registro IN DATE,
                                     p_estado IN VARCHAR2,
                                     p_codigo_error OUT NUMBER,
                                     p_mensaje_error OUT VARCHAR2) IS
    BEGIN
        -- Validaciones
        IF p_nombre IS NULL OR p_departamento IS NULL OR p_municipio IS NULL OR p_fecha_registro IS NULL OR p_estado IS NULL THEN
            p_codigo_error := 400;
            p_mensaje_error := 'Todos los campos son obligatorios.';
            RETURN;
        END IF;

        IF p_correo_electronico IS NOT NULL AND NOT REGEXP_LIKE(p_correo_electronico, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$') THEN
            p_codigo_error := 400;
            p_mensaje_error := 'El correo electrónico no tiene un formato válido.';
            RETURN;
        END IF;

        UPDATE Comerciante
        SET nombre = p_nombre,
            departamento = p_departamento,
            municipio = p_municipio,
            telefono = p_telefono,
            correo_electronico = p_correo_electronico,
            fecha_registro = p_fecha_registro,
            estado = p_estado,
            fecha_actualizacion = SYSDATE
        WHERE id_comerciante = p_id_comerciante; 

        p_codigo_error := 0;
        p_mensaje_error := NULL;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_codigo_error := 404;
            p_mensaje_error := 'Comerciante no encontrado.';
        WHEN OTHERS THEN
            p_codigo_error := SQLCODE;
            p_mensaje_error := SQLERRM;
    END actualizarComerciante;

    -- Procedimiento para eliminar comerciante
    PROCEDURE eliminarComerciante(p_id_comerciante IN NUMBER,
                                   p_codigo_error OUT NUMBER,
                                   p_mensaje_error OUT VARCHAR2) IS
    BEGIN
        DELETE FROM Comerciante WHERE id_comerciante = p_id_comerciante;

        IF SQL%ROWCOUNT = 0 THEN
            p_codigo_error := 404;
            p_mensaje_error := 'Comerciante no encontrado.';
        ELSE
            p_codigo_error := 0;
            p_mensaje_error := NULL;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_codigo_error := SQLCODE;
            p_mensaje_error := SQLERRM;
    END eliminarComerciante;

END Comerciante_PKG;


												/*RETO 5*/

CREATE OR REPLACE FUNCTION obtener_comerciantes_activos
RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT 
            c.nombre,
            c.departamento,
            c.municipio,
            c.telefono,
            c.correo_electronico,
            c.fecha_registro,
            c.estado,
            COUNT(e.id_establecimiento) AS cantidad_establecimientos,
            SUM(CASE WHEN e.estado = 'Activo' THEN 1 ELSE 0 END) AS total_activos,
            SUM(e.cantidad_empleados) AS cantidad_empleados
        FROM 
            Comerciante c
        LEFT JOIN 
            Establecimiento e ON c.id_comerciante = e.id_comerciante
        WHERE 
            c.estado = 'Activo'
        GROUP BY 
            c.id_comerciante, c.nombre, c.departamento, c.municipio, 
            c.telefono, c.correo_electronico, c.fecha_registro, c.estado
        ORDER BY 
            cantidad_establecimientos DESC;

    RETURN v_cursor;
END obtener_comerciantes_activos;
