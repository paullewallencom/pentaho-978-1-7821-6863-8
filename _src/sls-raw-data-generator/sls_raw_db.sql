SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `sls_raw` ;
CREATE SCHEMA IF NOT EXISTS `sls_raw` DEFAULT CHARACTER SET latin1 ;

USE `sls_raw` ;

-- -----------------------------------------------------
-- Table `sls_raw`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_raw`.`customer` ;

CREATE  TABLE IF NOT EXISTS `sls_raw`.`customer` (
  `customer_id` BIGINT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(100) NOT NULL ,
  `address` VARCHAR(255) NULL DEFAULT NULL ,
  `city` VARCHAR(70) NULL DEFAULT NULL ,
  `last_updated` DATE NULL ,
  PRIMARY KEY (`customer_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sls_raw`.`lens_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_raw`.`lens_category` ;

CREATE  TABLE IF NOT EXISTS `sls_raw`.`lens_category` (
  `lens_category_id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `lens_category` VARCHAR(70) NULL ,
  PRIMARY KEY (`lens_category_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sls_raw`.`lens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_raw`.`lens` ;

CREATE  TABLE IF NOT EXISTS `sls_raw`.`lens` (
  `lens_id` BIGINT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `year` INT(11) NULL DEFAULT NULL ,
  `lens_category_id` BIGINT(20) NOT NULL ,
  `focal_length_min` INT(11) NULL DEFAULT NULL ,
  `focal_length_max` INT(11) NULL DEFAULT NULL ,
  `aperture_max` DOUBLE NULL DEFAULT NULL ,
  `aperture_min` DOUBLE NULL DEFAULT NULL ,
  `focusing_distance_min` INT(11) NULL DEFAULT NULL ,
  `filter_size` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`lens_id`) ,
  INDEX `idx_lens_category` (`lens_category_id` ASC) ,
  CONSTRAINT `fk_lens_category`
    FOREIGN KEY (`lens_category_id` )
    REFERENCES `sls_raw`.`lens_category` (`lens_category_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sls_raw`.`sales_channel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_raw`.`sales_channel` ;

CREATE  TABLE IF NOT EXISTS `sls_raw`.`sales_channel` (
  `sales_channel_id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `sales_channel` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`sales_channel_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sls_raw`.`sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_raw`.`sale` ;

CREATE  TABLE IF NOT EXISTS `sls_raw`.`sale` (
  `sale_id` BIGINT NOT NULL AUTO_INCREMENT ,
  `date` DATE NOT NULL ,
  `customer_id` BIGINT NOT NULL ,
  `lens_id` BIGINT NOT NULL ,
  `sales_channel_id` BIGINT(20) NOT NULL ,
  `amount` DOUBLE NULL DEFAULT NULL ,
  INDEX `fk_customer_id_idx` (`customer_id` ASC) ,
  INDEX `fk_lens_id_idx` (`lens_id` ASC) ,
  PRIMARY KEY (`sale_id`) ,
  INDEX `fk_sale_sales_channel_idx` (`sales_channel_id` ASC) ,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id` )
    REFERENCES `sls_raw`.`customer` (`customer_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lens_id`
    FOREIGN KEY (`lens_id` )
    REFERENCES `sls_raw`.`lens` (`lens_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_sales_channel`
    FOREIGN KEY (`sales_channel_id` )
    REFERENCES `sls_raw`.`sales_channel` (`sales_channel_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
