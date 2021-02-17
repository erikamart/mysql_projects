SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `college_football` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `college_football` ;

-- -----------------------------------------------------
-- Table `college_football`.`coaches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_football`.`coaches` (
  `Coach_ID` INT NOT NULL AUTO_INCREMENT,
  `Team_ID` VARCHAR(4) NOT NULL,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Yrs_on_Team` INT NOT NULL,
  `Winning_Pct` INT NOT NULL,
  `Salary` BIGINT NULL,
  `Bowl_Wins` INT NOT NULL,
  `Bowl_Losses` INT NOT NULL,
  PRIMARY KEY (`Coach_ID`),
  INDEX `Team_ID_idx` (`Team_ID` ASC),
  CONSTRAINT `Team_ID`
    FOREIGN KEY (`Team_ID`)
    REFERENCES `college_football`.`teams` (`Team_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college_football`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_football`.`teams` (
  `Team_ID` VARCHAR(4) NOT NULL,
  `Coach_ID` INT NOT NULL AUTO_INCREMENT,
  `Team` VARCHAR(45) NOT NULL,
  `Stadium` VARCHAR(45) NOT NULL,
  `Stadium_Size` MEDIUMINT NOT NULL,
  `Conference` VARCHAR(45) NOT NULL,
  `Budget` BIGINT NOT NULL,
  `Record_of_128` INT NOT NULL,
  PRIMARY KEY (`Team_ID`),
  INDEX `Coach_ID_idx` (`Coach_ID` ASC),
  CONSTRAINT `Coach_ID`
    FOREIGN KEY (`Coach_ID`)
    REFERENCES `college_football`.`coaches` (`Coach_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college_football`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_football`.`players` (
  `Player_ID` INT NOT NULL AUTO_INCREMENT,
  `Team` VARCHAR(45) NOT NULL,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Rush_Receive_Rk` INT NOT NULL,
  `Rushing_Avg` DECIMAL(10,0) NULL,
  `Rushing_TD` INT NULL,
  `Receiving_Avg` DECIMAL(10,0) NULL,
  `Receiving_TD` INT NULL,
  PRIMARY KEY (`Player_ID`),
  INDEX `Team_idx` (`Team` ASC),
  CONSTRAINT `Team`
    FOREIGN KEY (`Team`)
    REFERENCES `college_football`.`teams` (`Team_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
