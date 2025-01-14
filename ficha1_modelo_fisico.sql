-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ficha1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ficha1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ficha1` DEFAULT CHARACTER SET utf8 ;
USE `ficha1` ;

-- -----------------------------------------------------
-- Table `ficha1`.`especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha1`.`especialidades` (
  `id_especialidades` INT NOT NULL AUTO_INCREMENT,
  `designacao` VARCHAR(45) NOT NULL,
  `preco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_especialidades`),
  UNIQUE INDEX `designacao_UNIQUE` (`designacao` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha1`.`cod_postal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha1`.`cod_postal` (
  `cod_postal` VARCHAR(12) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_postal`),
  UNIQUE INDEX `localidade_UNIQUE` (`localidade` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha1`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha1`.`medicos` (
  `nome` VARCHAR(45) NOT NULL,
  `id_medico` INT NOT NULL AUTO_INCREMENT,
  `idade` INT NOT NULL,
  `anos_servico` INT NOT NULL,
  `cp_medico` VARCHAR(12) NOT NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  INDEX `codigo_postal_idx` (`cp_medico` ASC) ,
  INDEX `especialidade_idx` (`especialidade` ASC) ,
  PRIMARY KEY (`id_medico`),
  CONSTRAINT `cp_medico`
    FOREIGN KEY (`cp_medico`)
    REFERENCES `ficha1`.`cod_postal` (`cod_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `especialidade`
    FOREIGN KEY (`especialidade`)
    REFERENCES `ficha1`.`especialidades` (`designacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha1`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha1`.`pacientes` (
  `sns` INT NOT NULL AUTO_INCREMENT,
  `data_nascimento` DATE NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idade` INT NULL,
  `cp_paciente` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`sns`),
  INDEX `codigo_postal_idx` (`cp_paciente` ASC) ,
  CONSTRAINT `cp_paciente`
    FOREIGN KEY (`cp_paciente`)
    REFERENCES `ficha1`.`cod_postal` (`cod_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ficha1`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ficha1`.`consultas` (
  `data` DATE NOT NULL,
  `hora` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(6,2) NOT NULL,
  `id_paciente` INT NOT NULL,
  `id_medico` INT NOT NULL,
  PRIMARY KEY (`data`, `hora`),
  INDEX `id_paciente_idx` (`id_paciente` ASC) ,
  INDEX `id_medico_idx` (`id_medico` ASC) ,
  CONSTRAINT `id_paciente`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `ficha1`.`pacientes` (`sns`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_medico`
    FOREIGN KEY (`id_medico`)
    REFERENCES `ficha1`.`medicos` (`id_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
