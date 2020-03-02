-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.19 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para introduccion_s_i
CREATE DATABASE IF NOT EXISTS `introduccion_s_i` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `introduccion_s_i`;

-- Volcando estructura para tabla introduccion_s_i.notes
CREATE TABLE IF NOT EXISTS `notes` (
  `student_code` int NOT NULL,
  `note` decimal(4,2) NOT NULL DEFAULT '0.00',
  `cycle` int(1) unsigned zerofill NOT NULL,
  PRIMARY KEY (`student_code`,`cycle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento introduccion_s_i.notesAdd
DELIMITER //
CREATE PROCEDURE `notesAdd`(
	IN `_student_code` INT,
	IN `_note` DECIMAL(4,2),
	IN `_cycle` INT
)
BEGIN
	INSERT INTO notes (student_code, note, cycle) VALUES(_student_code, _note, _cycle) ON DUPLICATE KEY UPDATE note = _note;
END//
DELIMITER ;

-- Volcando estructura para procedimiento introduccion_s_i.noteUpdate
DELIMITER //
CREATE PROCEDURE `noteUpdate`(
	IN `_student_code` INT,
	IN `_note` INT,
	IN `_cycle` INT
)
BEGIN
UPDATE notes SET
		note =_note
		WHERE code = _student_code AND  cycle = _cycle;
END//
DELIMITER ;

-- Volcando estructura para tabla introduccion_s_i.questions
CREATE TABLE IF NOT EXISTS `questions` (
  `cycle` int NOT NULL,
  `answer_ok` int DEFAULT NULL,
  `answer1` varchar(250) NOT NULL DEFAULT '',
  `answer2` varchar(250) NOT NULL DEFAULT '',
  `answer3` varchar(250) NOT NULL DEFAULT '',
  `question_literal` varchar(250) DEFAULT NULL,
  `question_number` int NOT NULL,
  PRIMARY KEY (`cycle`,`question_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla introduccion_s_i.student
CREATE TABLE IF NOT EXISTS `student` (
  `code` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'Undefined',
  `surname` varchar(50) NOT NULL DEFAULT 'Undefined',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para procedimiento introduccion_s_i.studentAddOrUpdate
DELIMITER //
CREATE PROCEDURE `studentAddOrUpdate`(
	IN `_name` CHAR(50),
	IN `_surname` VARCHAR(50),
	IN `_code` INT
)
BEGIN
IF _code = 0 THEN
		INSERT INTO student (name, surname) VALUES(_name, _surname);
			
	ELSE
	
	UPDATE student SET
		name =_name,
		surname = _surname
		WHERE code = _code;
	END IF;
	
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
