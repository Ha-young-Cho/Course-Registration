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
VALUES  ('01','본관'), ('04','4호관'), ('06','6호관'), ('07','학생회관'), ('09','9호관'), ('10', '운동장');

INSERT INTO Room 
VALUES      ('1123', '교육혁신센터', 30, '01'),
('1220', '총장실', 5, '01'),
('4302', '공간정보공학과 사무실', 20, '04'),
('6324', '경영대학원장실', 10, '06'),
('6139', '소비자생활 협동조합', 35, '06'),
('7313', '국제교류팀', 25, '07'),
('7343', '학생지원팀', 50, '07'),
('9212', '아태물류학부 사무실', 20, '09'),
('9408', '사회과학대학 학장실', 15, '09'),
('1000', '대운동장', 100, '10');

INSERT INTO Department 
VALUES      ('23410', '공간정보공학과', 'gong@ab.com', '0328607600'),
('20001', '아태물류학부', 'ate@bcd.com', '0328608222'),
('45200', '정보통신공학과', 'jung@ee.com', '0328607430'),
('16522', '통계학과', 'tong@ee.com', '0328607640'),
('75221', '경영학과', 'gyeong@ab.com', '0328607730');

INSERT INTO Class 
VALUES      ('ABC1002001', '공간정보입문', '홍길동', 30, '4302', '23410', 29),
('ABC2001002', '공간정보심화', '최영미', 30, '4302', '23410', 29),
('ICE4002001', '데이터베이스설계', '김철수', 50, '1123', '45200', 48),
('ICE2001003', '자료구조론', '박영희', 40, '7343', '45200', 39),
('EFG3003001', '기초통계학', '홍길순', 25,'7313', '16522', 24),
('WSE4005002', '아태물류학입문', '박미자', 20, '6139', '20001', 19),
('WSE1005001', '아태물류학심화', '김순자', 20, '9212', '20001', 20),
('VEF2001002', '경영학', '이지석', 45, '6324', '75221', 44);

INSERT INTO Student
VALUES      ('12194111', '조하영', 'cho@abc.com', '정보통신공학', '45200', '01055291920', 'test1234'),
('12179999', '아무개', 'ah@bdc.com', '통계학', '16522', '01011111222', 'test1234'),
('12202399', '황철수', 'hwang@ee.com', '경영학', '75221', '01055553333', 'test1234'),
('12185555', '최영수', 'choi@abcd.com', '공간정보공학', '23410', '01022254445', 'test1234'),
('12196666', '장길순', 'jang@ab.com', '아태물류학', '20001', '01077778888', 'test1234'),
('12200000', '홍순길', 'hong@abc.com', '정보통신공학', '45200', '01000000000', 'test1234');

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
VALUES      ('1111', '김길동', '과장', '01', '45200'),
('2222', '박철', '대리', '07', '16522'),
('3333', '최철수', '사원', '01', '45200'),
('4444', '황동식', '사원', '06', '75221'),
('5555', '정순자', '사원', '09', '20001');

INSERT INTO Club 
VALUES      ('2152', '영어회화 동아리', '7343'),
('1111', '탁구 동아리', '1123'),
('1980', '볼링 동아리', '1123'),
('2000', '축구 동아리', '1000'),
('1556', '농구 동아리', '1000'),
('2322', '천체관측 동아리', '7313');

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