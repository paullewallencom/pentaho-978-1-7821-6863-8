SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `sls_dma` ;
CREATE SCHEMA IF NOT EXISTS `sls_dma` DEFAULT CHARACTER SET latin1 ;
DROP SCHEMA IF EXISTS `sls_dma_agile` ;
CREATE SCHEMA IF NOT EXISTS `sls_dma_agile` ;
DROP SCHEMA IF EXISTS `sls_raw` ;
CREATE SCHEMA IF NOT EXISTS `sls_raw` DEFAULT CHARACTER SET latin1 ;
USE `sls_dma` ;

-- -----------------------------------------------------
-- Table `sls_dma`.`dim_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_dma`.`dim_customer` ;

CREATE  TABLE IF NOT EXISTS `sls_dma`.`dim_customer` (
  `customer_tk` BIGINT NOT NULL ,
  `version` INT(11) NULL DEFAULT NULL ,
  `date_from` DATETIME NULL DEFAULT NULL ,
  `date_to` DATETIME NULL DEFAULT NULL ,
  `customer_id` BIGINT NULL DEFAULT NULL ,
  `customer_name` VARCHAR(100) NULL DEFAULT NULL ,
  `address` VARCHAR(255) NULL DEFAULT NULL ,
  `city` VARCHAR(30) NULL DEFAULT NULL ,
  PRIMARY KEY (`customer_tk`) ,
  INDEX `idx_dim_customer_lookup` (`customer_id` ASC) ,
  INDEX `idx_dim_customer_tk` (`customer_tk` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sls_dma`.`dim_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_dma`.`dim_date` ;

CREATE  TABLE IF NOT EXISTS `sls_dma`.`dim_date` (
  `date_tk` BIGINT(20) NOT NULL ,
  `the_date` DATE NULL DEFAULT NULL ,
  `the_year` INT(11) NULL DEFAULT NULL ,
  `the_quarter` TINYINT(4) NULL DEFAULT NULL ,
  `the_month` SMALLINT(6) NULL DEFAULT NULL ,
  `day_of_year` INT(11) NULL DEFAULT NULL ,
  `day_of_month` SMALLINT(6) NULL DEFAULT NULL ,
  `day_of_week` SMALLINT(6) NULL DEFAULT NULL ,
  PRIMARY KEY (`date_tk`) ,
  INDEX `idx_dim_date_lookup` (`the_date` ASC) ,
  INDEX `idx_dim_date_tk` (`date_tk` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sls_dma`.`dim_lens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_dma`.`dim_lens` ;

CREATE  TABLE IF NOT EXISTS `sls_dma`.`dim_lens` (
  `lens_tk` BIGINT NOT NULL ,
  `version` INT(11) NULL DEFAULT NULL ,
  `date_from` DATETIME NULL DEFAULT NULL ,
  `date_to` DATETIME NULL DEFAULT NULL ,
  `lens_id` BIGINT NULL DEFAULT NULL ,
  `lens_name` VARCHAR(100) NULL DEFAULT NULL ,
  `year` INT(11) NULL DEFAULT NULL ,
  `lens_category` VARCHAR(70) NULL DEFAULT NULL ,
  `focal_length_min` INT(11) NULL DEFAULT NULL ,
  `focal_length_max` INT(11) NULL DEFAULT NULL ,
  `aperture_min` DOUBLE NULL DEFAULT NULL ,
  `aperture_max` DOUBLE NULL DEFAULT NULL ,
  `minimum_focusing_distance` INT(11) NULL DEFAULT NULL ,
  `filter` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`lens_tk`) ,
  INDEX `idx_dim_lens_lookup` (`lens_id` ASC) ,
  INDEX `idx_dim_lens_tk` (`lens_tk` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sls_dma`.`fact_sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_dma`.`fact_sale` ;

CREATE  TABLE IF NOT EXISTS `sls_dma`.`fact_sale` (
  `date_tk` BIGINT(20) NULL DEFAULT NULL ,
  `sale_id` BIGINT NULL ,
  `sales_channel` VARCHAR(70) NULL DEFAULT NULL ,
  `lens_tk` BIGINT NULL ,
  `customer_tk` BIGINT NULL ,
  `sales` DOUBLE NULL DEFAULT NULL ,
  INDEX `idx_customer_tk` (`customer_tk` ASC) ,
  INDEX `idx_lens_tk` (`lens_tk` ASC) ,
  INDEX `idx_date_tk` (`date_tk` ASC) ,
  INDEX `idx_sales_channel` (`sales_channel` ASC) ,
  UNIQUE INDEX `idx_composite_key` (`customer_tk` ASC, `lens_tk` ASC, `sales_channel` ASC, `sale_id` ASC, `date_tk` ASC) ,
  CONSTRAINT `fk_customer_tk`
    FOREIGN KEY (`customer_tk` )
    REFERENCES `sls_dma`.`dim_customer` (`customer_tk` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lens_tk`
    FOREIGN KEY (`lens_tk` )
    REFERENCES `sls_dma`.`dim_lens` (`lens_tk` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_date_tk`
    FOREIGN KEY (`date_tk` )
    REFERENCES `sls_dma`.`dim_date` (`date_tk` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `sls_dma_agile` ;

-- -----------------------------------------------------
-- Table `sls_dma_agile`.`fact_sales_agile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sls_dma_agile`.`fact_sales_agile` ;

CREATE  TABLE IF NOT EXISTS `sls_dma_agile`.`fact_sales_agile` (
  `lens_name` VARCHAR(100) NULL DEFAULT NULL ,
  `year` INT(11) NULL DEFAULT NULL ,
  `category` VARCHAR(70) NULL DEFAULT NULL ,
  `focus_length_min` INT(11) NULL DEFAULT NULL ,
  `focus_length_max` INT(11) NULL DEFAULT NULL ,
  `aperture_max` DOUBLE NULL DEFAULT NULL ,
  `aperture_min` DOUBLE NULL DEFAULT NULL ,
  `focus_distance_min` INT(11) NULL DEFAULT NULL ,
  `filter_size` INT(11) NULL DEFAULT NULL ,
  `lens_id` BIGINT(20) NULL DEFAULT NULL ,
  `trans_id` BIGINT(20) NULL DEFAULT NULL ,
  `sale_date` DATE NULL DEFAULT NULL ,
  `customer_id` BIGINT(20) NULL DEFAULT NULL ,
  `sales_channel` VARCHAR(70) NULL DEFAULT NULL ,
  `sales` DOUBLE NULL DEFAULT NULL ,
  `customer_name` VARCHAR(70) NULL DEFAULT NULL ,
  `address` VARCHAR(255) NULL DEFAULT NULL ,
  `city` VARCHAR(70) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

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

USE `sls_dma` ;
USE `sls_dma_agile` ;
USE `sls_raw` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
