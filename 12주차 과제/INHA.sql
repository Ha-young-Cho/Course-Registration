-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hw04
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hw04
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hw04` DEFAULT CHARACTER SET utf8mb3 ;
USE `hw04` ;

-- -----------------------------------------------------
-- Table `hw04`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`building` (
  `B_id` CHAR(2) NOT NULL,
  `B_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`B_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`department` (
  `D_id` CHAR(10) NOT NULL,
  `D_name` VARCHAR(45) NOT NULL,
  `D_email` VARCHAR(45) NULL DEFAULT NULL,
  `D_phone_number` INT NULL DEFAULT NULL,
  PRIMARY KEY (`D_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`room` (
  `R_id` CHAR(4) NOT NULL,
  `R_name` VARCHAR(45) NOT NULL,
  `capacity` INT NULL DEFAULT NULL,
  `B_id` CHAR(2) NOT NULL,
  PRIMARY KEY (`R_id`),
  INDEX `fk_Room_Building_idx` (`B_id` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Building`
    FOREIGN KEY (`B_id`)
    REFERENCES `hw04`.`building` (`B_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`class` (
  `C_id` CHAR(10) NOT NULL,
  `C_name` VARCHAR(45) NOT NULL,
  `professor` VARCHAR(45) NULL DEFAULT NULL,
  `number_of_participants` INT NULL DEFAULT NULL,
  `R_id` CHAR(4) NOT NULL,
  `D_id` CHAR(10) NOT NULL,
  `availability` INT NULL DEFAULT NULL,
  PRIMARY KEY (`C_id`),
  INDEX `fk_Class_Room1_idx` (`R_id` ASC) VISIBLE,
  INDEX `fk_Class_Department1_idx` (`D_id` ASC) VISIBLE,
  INDEX `class_on_cname` USING BTREE (`C_name`) VISIBLE,
  INDEX `class_on_cid` USING BTREE (`C_id`) VISIBLE,
  CONSTRAINT `fk_Class_Department1`
    FOREIGN KEY (`D_id`)
    REFERENCES `hw04`.`department` (`D_id`),
  CONSTRAINT `fk_Class_Room1`
    FOREIGN KEY (`R_id`)
    REFERENCES `hw04`.`room` (`R_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`club` (
  `Club_id` CHAR(4) NOT NULL,
  `Club_name` VARCHAR(45) NOT NULL,
  `R_id` CHAR(4) NOT NULL,
  PRIMARY KEY (`Club_id`),
  INDEX `fk_Club_Room1_idx` (`R_id` ASC) VISIBLE,
  CONSTRAINT `fk_Club_Room1`
    FOREIGN KEY (`R_id`)
    REFERENCES `hw04`.`room` (`R_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`employee` (
  `E_id` CHAR(8) NOT NULL,
  `E_name` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NULL DEFAULT NULL,
  `B_id` CHAR(2) NOT NULL,
  `D_id` CHAR(5) NOT NULL,
  PRIMARY KEY (`E_id`),
  INDEX `fk_Employee_Building1_idx` (`B_id` ASC) VISIBLE,
  INDEX `fk_Employee_Department1_idx` (`D_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Building1`
    FOREIGN KEY (`B_id`)
    REFERENCES `hw04`.`building` (`B_id`),
  CONSTRAINT `fk_Employee_Department1`
    FOREIGN KEY (`D_id`)
    REFERENCES `hw04`.`department` (`D_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`student` (
  `S_id` CHAR(8) NOT NULL,
  `S_name` VARCHAR(45) NOT NULL,
  `S_email` VARCHAR(45) NULL DEFAULT NULL,
  `major` VARCHAR(45) NULL DEFAULT NULL,
  `D_id` CHAR(5) NOT NULL,
  `S_phone_number` CHAR(13) NULL DEFAULT NULL,
  `S_pw` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`S_id`),
  INDEX `fk_Student_Department1_idx` (`D_id` ASC) VISIBLE,
  INDEX `student_on_sid` USING BTREE (`S_id`) VISIBLE,
  CONSTRAINT `fk_Student_Department1`
    FOREIGN KEY (`D_id`)
    REFERENCES `hw04`.`department` (`D_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`take_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`take_class` (
  `S_id` CHAR(8) NOT NULL,
  `C_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`S_id`, `C_id`),
  INDEX `fk_Student_has_Class_Class1_idx` (`C_id` ASC) VISIBLE,
  INDEX `fk_Student_has_Class_Student1_idx` (`S_id` ASC) VISIBLE,
  CONSTRAINT `fk_Student_has_Class_Class1`
    FOREIGN KEY (`C_id`)
    REFERENCES `hw04`.`class` (`C_id`),
  CONSTRAINT `fk_Student_has_Class_Student1`
    FOREIGN KEY (`S_id`)
    REFERENCES `hw04`.`student` (`S_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`take_club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`take_club` (
  `Club_id` CHAR(4) NOT NULL,
  `S_id` CHAR(8) NOT NULL,
  PRIMARY KEY (`Club_id`, `S_id`),
  INDEX `fk_Club_has_Student_Student1_idx` (`S_id` ASC) VISIBLE,
  INDEX `fk_Club_has_Student_Club1_idx` (`Club_id` ASC) VISIBLE,
  CONSTRAINT `fk_Club_has_Student_Club1`
    FOREIGN KEY (`Club_id`)
    REFERENCES `hw04`.`club` (`Club_id`),
  CONSTRAINT `fk_Club_has_Student_Student1`
    FOREIGN KEY (`S_id`)
    REFERENCES `hw04`.`student` (`S_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `hw04`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hw04`.`user` (
  `Id` VARCHAR(20) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  `Role` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Building 
VALUES  ('01','??????'), ('04','4??????'), ('06','6??????'), ('07','????????????'), ('09','9??????'), ('10', '?????????');

INSERT INTO Room 
VALUES      ('1123', '??????????????????', 30, '01'),
('1220', '?????????', 5, '01'),
('4302', '????????????????????? ?????????', 20, '04'),
('6324', '?????????????????????', 10, '06'),
('6139', '??????????????? ????????????', 35, '06'),
('7313', '???????????????', 25, '07'),
('7343', '???????????????', 50, '07'),
('9212', '?????????????????? ?????????', 20, '09'),
('9408', '?????????????????? ?????????', 15, '09'),
('1000', '????????????', 100, '10');

INSERT INTO Department 
VALUES      ('23410', '?????????????????????', 'gong@ab.com', '0328607600'),
('20001', '??????????????????', 'ate@bcd.com', '0328608222'),
('45200', '?????????????????????', 'jung@ee.com', '0328607430'),
('16522', '????????????', 'tong@ee.com', '0328607640'),
('75221', '????????????', 'gyeong@ab.com', '0328607730');

INSERT INTO Class 
VALUES      ('ABC1002001', '??????????????????', '?????????', 30, '4302', '23410', 29),
('ABC2001002', '??????????????????', '?????????', 30, '4302', '23410', 29),
('ICE4002001', '????????????????????????', '?????????', 50, '1123', '45200', 48),
('ICE2001003', '???????????????', '?????????', 40, '7343', '45200', 39),
('EFG3003001', '???????????????', '?????????', 25,'7313', '16522', 24),
('WSE4005002', '?????????????????????', '?????????', 20, '6139', '20001', 19),
('WSE1005001', '?????????????????????', '?????????', 20, '9212', '20001', 20),
('VEF2001002', '?????????', '?????????', 45, '6324', '75221', 44);

INSERT INTO Student
VALUES      ('12194111', '?????????', 'cho@abc.com', '??????????????????', '45200', '01055291920', 'test1234'),
('12179999', '?????????', 'ah@bdc.com', '?????????', '16522', '01011111222', 'test1234'),
('12202399', '?????????', 'hwang@ee.com', '?????????', '75221', '01055553333', 'test1234'),
('12185555', '?????????', 'choi@abcd.com', '??????????????????', '23410', '01022254445', 'test1234'),
('12196666', '?????????', 'jang@ab.com', '???????????????', '20001', '01077778888', 'test1234'),
('12200000', '?????????', 'hong@abc.com', '??????????????????', '45200', '01000000000', 'test1234');

INSERT INTO Take_class 
VALUES      ('12194111', 'ICE4002001'),
('12194111', 'ABC1002001'),
('12202399', 'VEF2001002'),
('12196666', 'WSE4005002'),
('12200000', 'ICE4002001'),
('12179999', 'EFG3003001'),
('12179999', 'ICE2001003'),
('12185555', 'ABC2001002');

INSERT INTO Employee 
VALUES      ('1111', '?????????', '??????', '01', '45200'),
('2222', '??????', '??????', '07', '16522'),
('3333', '?????????', '??????', '01', '45200'),
('4444', '?????????', '??????', '06', '75221'),
('5555', '?????????', '??????', '09', '20001');

INSERT INTO Club 
VALUES      ('2152', '???????????? ?????????', '7343'),
('1111', '?????? ?????????', '1123'),
('1980', '?????? ?????????', '1123'),
('2000', '?????? ?????????', '1000'),
('1556', '?????? ?????????', '1000'),
('2322', '???????????? ?????????', '7313');

INSERT INTO Take_club 
VALUES      ('2152', '12194111'),
('1111', '12202399'),
('1980', '12179999'),
('2000', '12200000'),
('1556', '12185555'),
('2322', '12196666');

INSERT INTO User 
VALUES      ('12194111', 'test4111', 'student'),
('12202399', 'test2399', 'student'),
('12179999', 'test9999', 'student'),
('12200000', 'test0000', 'student'),
('12185555', 'test5555', 'student'),
('12196666', 'test6666', 'student'),
('admin', 'admin1234', 'super');