CREATE DATABASE matriculas
USE matriculas

CREATE TABLE personas
(
	idPersona		INT AUTO_INCREMENT PRIMARY KEY,
	nombre 			VARCHAR(50)		NOT NULL,
	apellido			VARCHAR(50)		NOT NULL,
	direccion		VARCHAR(50)		NOT NULL,
	telefono			INT 				NOT NULL,
	correo			VARCHAR(50)		NOT NULL,
	fechaNac			DATE 				NOT NULL,
	tipoDoc			VARCHAR(30)		NOT NULL,
	numDoc			VARCHAR(20)		NOT NULL,
	CONSTRAINT uk_numDoc UNIQUE (numDoc)
)
ENGINE = INNODB

INSERT INTO personas (nombre, apellido, direccion, telefono, correo, fechaNac, tipoDoc, numDoc) VALUES
						('Angelo', 'Farfan Torres', 'chincha baja 203', '953221053', 'angelo@gmail.com', '01-07-2004', 'DNI', '85484523'),
						('Lucio', 'Medina Llano', 'Jr. union 115', '985346852', 'lucio@gmail.com', '17-10-2003','DNI', '854762354'),
						('Jean', 'Mateo Quispe', 'Sunampe Chacarita 12', '975268413', 'Jean@gmail.com', '26-12-2000', 'DNI', '574692138'),
						('Alex', 'Quiroga Caulla', 'Carmen Calle ariola 13', '947825631', 'Alex@gmail.com', '08-01-2004', 'DNI', '47851236'),
						('Ronald', 'Mendoza Rios', 'Su Casa', '948571263', 'Ronald@gmail.com', '25-06-2003', 'DNI', '84571263')

SELECT * FROM personas

CREATE TABLE cursos
(
	idCursos			INT AUTO_INCREMENT PRIMARY KEY,
	nombreCurso		VARCHAR(80)		NOT NULL
)
ENGINE = INNODB

INSERT INTO cursos (nombreCurso) VALUES
						('Matematica'),
						('Literatura'),
						('Ingles'),
						('Seguridad Industrial'),
						('Calidad Total')

SELECT * FROM cursos						
						
CREATE TABLE usuarios
(
	idUsuario		INT AUTO_INCREMENT PRIMARY KEY,
	idPersona		INT 				NOT NULL,
	nombreUsuario	VARCHAR(50)		NOT NULL,
	claveAcceso		VARCHAR(50)		NOT NULL,
	CONSTRAINT fk_idpersona FOREIGN KEY (idPersona) REFERENCES personas (idPersona)
)
ENGINE = INNODB

ALTER TABLE usuarios INSERT estado CHAR(1) NOT NULL DEFAULT '1',

INSERT INTO usuarios (idPersona, nombreUsuario, claveAcceso) VALUES
				    (1, 'Angelitotuterror', 'pollitoconpapas')
				    
SELECT * FROM usuarios

/* angelito tu terror: pollitoconpapas */
UPDATE usuarios
	SET claveAcceso = 'idUgF9zIWY54WlrVM294Ygbx8YGH1yrkVEoYaZ6Zbew'
	WHERE idUsuario = 1;

INSERT INTO usuarios (idPersona, nombreUsuario, claveAcceso) VALUES
							(3, 'xifujean', 'lovemostaza')
							
/*xifujean: lovemostaza*/
UPDATE usuarios
	SET claveAcceso = 'dQWnY1Y3whKdMubuvEneg2ioeA5s0ub/1iG2o5pq8PI'
	WHERE idUsuario = 2;

DELIMITER $$
CREATE PROCEDURE spu_usuarios_login(IN _nombreUsuario VARCHAR(50))
BEGIN
	SELECT 	idUsuario,
				nombreUsuario,
				claveAcceso
			FROM usuarios
			WHERE nombreUsuario = _nombreUsuario AND estado = '1';
END $$

CREATE TABLE carrera
(
	idCarrera		INT AUTO_INCREMENT PRIMARY KEY,
	idCursos			INT 				NOT NULL,
	nombreCarrera	VARCHAR(80)		NOT NULL,
	fechaInicio		DATE 				NOT NULL,
	fechaFinal		DATE 				NOT NULL,
	periodo			VARCHAR(50) 	NOT NULL,
	semestre			VARCHAR(50) 	NOT NULL,
	estado			CHAR(1) NOT NULL DEFAULT '1',
	CONSTRAINT fk_idcurso FOREIGN KEY (idCursos) REFERENCES cursos (idCursos)
)
ENGINE = INNODB

INSERT INTO carrera (idCursos, nombreCarrera, fechaInicio, fechaFinal, periodo, semestre) VALUES
						(1, 'Administracion Industrial', '23-05-2023', '23-11-2023', '2023', 'III'),
						(2, 'Diseño Grafico', '23-06-2023', '23-10-2023', '2023', 'IV'),
						(3, 'Ingenieria de Software', '20-07-2023', '20-12-2023', '2023', 'V')

SELECT * FROM carrera


CREATE TABLE alumnos 
(
	idAlumno			INT AUTO_INCREMENT PRIMARY KEY,
	idPersona		INT 			NOT NULL,
	estado 			CHAR(1)		NOT NULL DEFAULT '1',
	CONSTRAINT fk_r1 FOREIGN KEY (idPersona) REFERENCES personas (idPersona)
)
ENGINE = INNODB

CREATE TABLE docente
(
	idDocente		INT AUTO_INCREMENT PRIMARY KEY,
	idPersona		INT 					NOT NULL,
	idCursos			INT 					NOT NULL,
	especialidad	VARCHAR(100)		NOT NULL,
	estado			CHAR(1) NOT NULL DEFAULT '1',
	CONSTRAINT r2 FOREIGN KEY (idPersona) REFERENCES personas (idPersona),
	CONSTRAINT r3 FOREIGN KEY (idCursos) REFERENCES cursos (idCursos)
)
ENGINE = INNODB

CREATE TABLE matricula
(
	idMatricula		INT AUTO_INCREMENT PRIMARY KEY,
	idAlumno			INT 				NOT NULL,
	idDocente		INT 				NOT NULL,
	idUsuario		INT 				NOT NULL,
	idCarrera 		INT 				NOT NULL,
	fecha				DATE 				NOT NULL,
	monto				DECIMAL(7,2)	NOT NULL,
	CONSTRAINT r4 FOREIGN KEY (idAlumno)  REFERENCES alumnos (idAlumno),
	CONSTRAINT r5 FOREIGN KEY (idDocente) REFERENCES docente (idDocente),
	CONSTRAINT r6 FOREIGN KEY (idUsuario) REFERENCES usuarios (idUsuario),
	CONSTRAINT r7 FOREIGN KEY (idCarrera) REFERENCES carrera (idCarrera)
) 
ENGINE = INNODB

SELECT * FROM matricula
























