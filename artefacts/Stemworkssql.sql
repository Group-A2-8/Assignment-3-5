-- MySQL Script generated by MySQL Workbench
-- Sun 24 May 2020 12:42:11
-- Model: Stemworks    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Stemworksdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Stemworksdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Stemworksdb` DEFAULT CHARACTER SET utf8 ;
USE `Stemworksdb` ;

-- -----------------------------------------------------
-- Table `Stemworksdb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`country` (
  `country_id` INT NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `northern_hemisphere` TINYINT(1) NULL DEFAULT NULL,
  `southern_hemisphere` TINYINT(1) NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`city` (
  `city_id` INT NOT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `country_id` INT NOT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_1`
    FOREIGN KEY (`country_id`)
    REFERENCES `Stemworksdb`.`country` (`country_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`temperature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`temperature` (
  `temperature_id` INT NOT NULL,
  `temp_max` DECIMAL NULL DEFAULT NULL,
  `temp_min` DECIMAL NULL DEFAULT NULL,
  `growth_id` INT NULL DEFAULT NULL,
  `temp_range` VARCHAR(45) NULL,
  `Plant_id` INT NULL,
  PRIMARY KEY (`temperature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`growth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`growth` (
  `growth_id` INT NOT NULL,
  `temperature_id` INT NULL DEFAULT NULL,
  `growth_day` DOUBLE NULL DEFAULT NULL,
  `growth_week` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`growth_id`),
  INDEX `fk_growth_1_idx` (`temperature_id` ASC) VISIBLE,
  CONSTRAINT `fk_growth_1`
    FOREIGN KEY (`temperature_id`)
    REFERENCES `Stemworksdb`.`temperature` (`temperature_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`address` (
  `address_id` INT NOT NULL,
  `address01` VARCHAR(45) NULL DEFAULT NULL,
  `address02` VARCHAR(45) NULL DEFAULT NULL,
  `city_id` INT NOT NULL,
  `postcode` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_1`
    FOREIGN KEY (`city_id`)
    REFERENCES `Stemworksdb`.`city` (`city_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`customer` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `active` TINYINT(1) NULL DEFAULT NULL,
  `creation_date` DATETIME NULL DEFAULT NULL,
  `address_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_1`
    FOREIGN KEY (`address_id`)
    REFERENCES `Stemworksdb`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`supplier` (
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(45) NULL DEFAULT NULL,
  `supplier_email` VARCHAR(45) NULL DEFAULT NULL,
  `active` TINYINT(1) NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  INDEX `fk_supplier_1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Stemworksdb`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`device` (
  `device_id` INT NOT NULL,
  `device_type` VARCHAR(45) NULL DEFAULT NULL,
  `device_name` VARCHAR(45) NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `fk_device_1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_device_2_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_device_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Stemworksdb`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_device_2`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `Stemworksdb`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`phlevels_vegetables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`phlevels_vegetables` (
  `phlevels_id` INT NOT NULL,
  `phlevels_max` DOUBLE NULL DEFAULT NULL,
  `phlevels_min` DOUBLE NULL DEFAULT NULL,
  `Vegetable_id` INT NULL DEFAULT NULL,
  `cflevel` DOUBLE NULL,
  `ppmlevel` DOUBLE NULL,
  PRIMARY KEY (`phlevels_id`),
  INDEX `fk_phlevels_vegetables_1_idx` (`Vegetable_id` ASC) VISIBLE,
  CONSTRAINT `fk_phlevels_vegetables_1`
    FOREIGN KEY (`Vegetable_id`)
    REFERENCES `Stemworksdb`.`plant_vegetable` (`Vegetable_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`plant_vegetable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`plant_vegetable` (
  `Vegetable_id` INT NOT NULL,
  `Plant_name` VARCHAR(45) NULL DEFAULT NULL,
  `Plant_name_latin` VARCHAR(45) NULL DEFAULT NULL,
  `growth_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `plant_image` LONGBLOB NULL,
  PRIMARY KEY (`Vegetable_id`),
  INDEX `fk_Plant_1_idx` (`growth_id` ASC) VISIBLE,
  INDEX `fk_Plant_2_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Plant_3_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_plant_vegetable_4`
    FOREIGN KEY (`growth_id`)
    REFERENCES `Stemworksdb`.`growth` (`growth_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_vegetable_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Stemworksdb`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_vegetable_3`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `Stemworksdb`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_vegetable_1`
    FOREIGN KEY (`Vegetable_id`)
    REFERENCES `Stemworksdb`.`phlevels_vegetables` (`phlevels_id`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`plant_herbs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`plant_herbs` (
  `Herb_id` INT NOT NULL,
  `Plant_name` VARCHAR(45) NULL DEFAULT NULL,
  `Plant_name_latin` VARCHAR(45) NULL DEFAULT NULL,
  `growth_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `plant_image` LONGBLOB NULL,
  PRIMARY KEY (`Herb_id`),
  INDEX `fk_Plant_1_idx` (`growth_id` ASC, `Herb_id` ASC) VISIBLE,
  INDEX `fk_Plant_2_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Plant_3_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_plant_herbs_2`
    FOREIGN KEY (`growth_id` , `Herb_id`)
    REFERENCES `Stemworksdb`.`growth` (`growth_id` , `growth_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_herbs_3`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Stemworksdb`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_herbs_4`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `Stemworksdb`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_herbs_1`
    FOREIGN KEY (`Herb_id`)
    REFERENCES `Stemworksdb`.`plant_herbs` (`growth_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`phlevels_herb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`phlevels_herb` (
  `phlevels_id` INT NOT NULL,
  `phlevels_max` DOUBLE NULL DEFAULT NULL,
  `phlevels_min` DOUBLE NULL DEFAULT NULL,
  `Herb_id` INT NULL DEFAULT NULL,
  `cflevel` DOUBLE NULL,
  `ppmlevel` DOUBLE NULL,
  PRIMARY KEY (`phlevels_id`),
  INDEX `fk_phlevels_herb_1_idx` (`Herb_id` ASC) VISIBLE,
  CONSTRAINT `fk_phlevels_herb_1`
    FOREIGN KEY (`Herb_id`)
    REFERENCES `Stemworksdb`.`plant_herbs` (`Herb_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`plant_fruit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`plant_fruit` (
  `Fruit_id` INT NOT NULL,
  `Plant_name` VARCHAR(45) NULL DEFAULT NULL,
  `Plant_name_latin` VARCHAR(45) NULL DEFAULT NULL,
  `growth_id` INT NULL DEFAULT NULL,
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `plant_image` LONGBLOB NULL,
  PRIMARY KEY (`Fruit_id`),
  INDEX `fk_Plant_1_idx` (`growth_id` ASC) VISIBLE,
  INDEX `fk_Plant_2_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Plant_3_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_plant_fruit_2`
    FOREIGN KEY (`growth_id`)
    REFERENCES `Stemworksdb`.`growth` (`growth_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_fruit_3`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Stemworksdb`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_fruit_4`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `Stemworksdb`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plant_fruit_1`
    FOREIGN KEY (`Fruit_id`)
    REFERENCES `Stemworksdb`.`phlevels_vegetables` (`phlevels_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stemworksdb`.`phlevels_fruit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stemworksdb`.`phlevels_fruit` (
  `phlevels_id` INT NOT NULL,
  `phlevels_max` DOUBLE NULL DEFAULT NULL,
  `phlevels_min` DOUBLE NULL DEFAULT NULL,
  `Fruit_id` INT NULL DEFAULT NULL,
  `cflevel` DOUBLE NULL,
  `ppmlevel` DOUBLE NULL,
  PRIMARY KEY (`phlevels_id`),
  INDEX `fk_phlevels_fruit_1_idx` (`Fruit_id` ASC) VISIBLE,
  CONSTRAINT `fk_phlevels_fruit_1`
    FOREIGN KEY (`Fruit_id`)
    REFERENCES `Stemworksdb`.`plant_fruit` (`Fruit_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
