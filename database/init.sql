-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema kursach
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kursach
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kursach` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `kursach` ;

-- -----------------------------------------------------
-- Table `kursach`.`hotel_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`hotel_room` (
  `idhotel_room` INT NOT NULL,
  `num_room` INT NULL DEFAULT NULL,
  `cost_for_day` INT NOT NULL,
  `statys` VARCHAR(200) NULL DEFAULT NULL,
  `floor` INT NULL DEFAULT NULL,
  `photo` VARCHAR(45) NULL DEFAULT 'zz.jpg',
  PRIMARY KEY (`idhotel_room`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kursach`.`klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`klient` (
  `idklient` INT NOT NULL AUTO_INCREMENT,
  `FIO` VARCHAR(45) NULL DEFAULT NULL,
  `Passport` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idklient`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kursach`.`bronirovanie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`bronirovanie` (
  `hotel_room_idhotel_room` INT NOT NULL,
  `klient_idklient` INT NOT NULL,
  `Date_arrival` DATE NULL DEFAULT NULL,
  `Date_of_departure` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`hotel_room_idhotel_room`, `klient_idklient`),
  INDEX `fk_hotel_room_has_klient_klient1_idx` (`klient_idklient` ASC) VISIBLE,
  INDEX `fk_hotel_room_has_klient_hotel_room1_idx` (`hotel_room_idhotel_room` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_room_has_klient_hotel_room1`
    FOREIGN KEY (`hotel_room_idhotel_room`)
    REFERENCES `kursach`.`hotel_room` (`idhotel_room`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_hotel_room_has_klient_klient1`
    FOREIGN KEY (`klient_idklient`)
    REFERENCES `kursach`.`klient` (`idklient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kursach`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`payment` (
  `hotel_room_idhotel_room` INT NOT NULL,
  `klient_idklient` INT NOT NULL,
  `cost_full` INT NULL DEFAULT NULL,
  `receipt_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`hotel_room_idhotel_room`, `klient_idklient`),
  INDEX `fk_hotel_room_has_klient_klient2_idx` (`klient_idklient` ASC) VISIBLE,
  INDEX `fk_hotel_room_has_klient_hotel_room2_idx` (`hotel_room_idhotel_room` ASC) VISIBLE,
  CONSTRAINT `fk_hotel_room_has_klient_hotel_room2`
    FOREIGN KEY (`hotel_room_idhotel_room`)
    REFERENCES `kursach`.`hotel_room` (`idhotel_room`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_hotel_room_has_klient_klient2`
    FOREIGN KEY (`klient_idklient`)
    REFERENCES `kursach`.`klient` (`idklient`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kursach`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`role` (
  `idrole` INT NOT NULL,
  `name_role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idrole`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `kursach`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kursach`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `name_user` VARCHAR(45) NULL DEFAULT NULL,
  `login` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `role_idrole` INT NOT NULL DEFAULT '2',
  PRIMARY KEY (`iduser`),
  INDEX `fk_user_role_idx` (`role_idrole` ASC) VISIBLE,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_idrole`)
    REFERENCES `kursach`.`role` (`idrole`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `kursach` ;

-- -----------------------------------------------------
-- procedure fullcost
-- -----------------------------------------------------

DELIMITER $$
USE `kursach`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fullcost`(IN b INT, IN c INT)
BEGIN
declare result int;
    SET result = b * c;
    select result;
END$$

DELIMITER ;
USE `kursach`;

DELIMITER $$
USE `kursach`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `kursach`.`hotel_room_BEFORE_UPDATE`
BEFORE UPDATE ON `kursach`.`hotel_room`
FOR EACH ROW
BEGIN
 IF NEW.statys != 'Свободен' AND NEW.statys != 'Занят' THEN
       SET NEW.statys = OLD.statys;
     END IF;
END$$

USE `kursach`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `kursach`.`bronirovanie_BEFORE_DELETE`
BEFORE DELETE ON `kursach`.`bronirovanie`
FOR EACH ROW
BEGIN
UPDATE hotel_room
    SET statys = 'Свободен'
    WHERE idhotel_room = OLD.hotel_room_idhotel_room;
END$$

USE `kursach`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `kursach`.`bronirovanie_BEFORE_INSERT`
BEFORE INSERT ON `kursach`.`bronirovanie`
FOR EACH ROW
BEGIN
 IF NEW.Date_arrival>new.Date_of_departure  THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Дата приезда не может быть больше даты уезда"';
    END IF;
END$$

USE `kursach`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `kursach`.`payment_AFTER_INSERT`
AFTER INSERT ON `kursach`.`payment`
FOR EACH ROW
BEGIN
UPDATE hotel_room
SET statys = 'Занят'
WHERE idhotel_room = NEW.hotel_room_idhotel_room;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
