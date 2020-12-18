-- -----------------------------------------------------
-- Schema MiniEasyPeasyCook
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MiniEasyPeasyCook` DEFAULT CHARACTER SET utf8 ;
USE `MiniEasyPeasyCook` ;


-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`Gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`Gender` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(50) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

use MiniEasyPeasyCook;

-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`User` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(100) NOT NULL,
  `Name` VARCHAR(250) NOT NULL,
  `Email` VARCHAR(250) NULL,
  `Password` VARCHAR(250) NULL,
  `CreationTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `ProfileImageUrl` VARCHAR(250) NULL,
  `GenderID` INT NOT NULL DEFAULT 1,

  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_User_GenderID`
    FOREIGN KEY (`GenderID`)
    REFERENCES `MiniInsta`.`Gender` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`Recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`Recipe` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CreationTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `UserID` INT NOT NULL,
  `FoodName` VARCHAR(250) NOT NULL,
  `Description` VARCHAR(500) NOT NULL,
  `Recipe` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_Recipe_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `MiniEasyPeasyCook`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`Liking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`Liking` (
  `RecipeID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `CreationTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecipeID`, `UserID`),
  CONSTRAINT `FK_Liking_Recipe`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `MiniEasyPeasyCook`.`Recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Liking_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `MiniEasyPeasyCook`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`Saving`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`Saving` (
  `RecipeID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `CreationTime` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecipeID`, `UserID`),
  CONSTRAINT `FK_Saving_Recipe`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `MiniEasyPeasyCook`.`Recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Saving_User`
    FOREIGN KEY (`UserID`)
    REFERENCES `MiniEasyPeasyCook`.`User` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `MiniEasyPeasyCook`.`Image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiniEasyPeasyCook`.`Image` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RecipeID` INT NOT NULL,
  `ImageFileUrl` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_Image_Recipe`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `MiniEasyPeasyCook`.`Recipe` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


