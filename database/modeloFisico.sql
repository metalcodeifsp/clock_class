-- MySQL Script generated by MySQL Workbench
-- dom 10 set 2017 13:49:25 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema horario
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `horario` ;

-- -----------------------------------------------------
-- Schema horario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `horario` DEFAULT CHARACTER SET latin1 ;
USE `horario` ;

-- -----------------------------------------------------
-- Table `horario`.`grau`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`grau` ;

CREATE TABLE IF NOT EXISTS `horario`.`grau` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome_grau` VARCHAR(50) NOT NULL,
  `codigo` INT NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `horario`.`tipo_sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `horario`.`tipo_sala` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `nome_tipo_sala` VARCHAR(30) NOT NULL,
  `descricao_tipo_sala` VARCHAR(254) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `horario`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`curso` ;

CREATE TABLE IF NOT EXISTS `horario`.`curso` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `grau_id` TINYINT NOT NULL,
  `codigo_curso` CHAR(5) NOT NULL,
  `nome_curso` VARCHAR(75) NOT NULL,
  `sigla_curso` CHAR(3) NOT NULL,
  `qtd_semestre` TINYINT(2) NOT NULL,
  `fechamento` CHAR(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_curso_grau1_idx` (`grau_id` ASC),
  CONSTRAINT `fk_curso_grau1`
    FOREIGN KEY (`grau_id`)
    REFERENCES `horario`.`grau` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`tipo_sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`tipo_sala` ;

CREATE TABLE IF NOT EXISTS `horario`.`tipo_sala` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome_tipo_sala` VARCHAR(30) NOT NULL,
  `descricao_tipo_sala` VARCHAR(254) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`disciplina` ;

CREATE TABLE IF NOT EXISTS `horario`.`disciplina` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `curso_id` SMALLINT(6) NOT NULL,
  `tipo_sala_id` TINYINT NOT NULL,
  `nome_disciplina` VARCHAR(50) NOT NULL,
  `sigla_disciplina` CHAR(5) NOT NULL,
  `qtd_professor` TINYINT(1) NOT NULL,
  `qtd_aulas` TINYINT(2) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_disciplina_curso1_idx` (`curso_id` ASC),
  INDEX `fk_disciplina_tipo_sala` (`tipo_sala_id` ASC),
  CONSTRAINT `fk_disciplina_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `horario`.`curso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_disciplina_tipo_sala`
    FOREIGN KEY (`tipo_sala_id`)
    REFERENCES `horario`.`tipo_sala` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`turno` ;

CREATE TABLE IF NOT EXISTS `horario`.`turno` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome_turno` VARCHAR(25) NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_turno_UNIQUE` (`nome_turno` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `horario`.`horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`horario` ;

CREATE TABLE IF NOT EXISTS `horario`.`horario` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `turno_id` TINYINT(4) NOT NULL,
  `inicio` TIME NOT NULL,
  `fim` TIME NOT NULL,
  `deletado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_horario_turno_idx` (`turno_id` ASC),
  CONSTRAINT `fk_horario_turno`
    FOREIGN KEY (`turno_id`)
    REFERENCES `horario`.`turno` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

INSERT INTO grau(nome_grau, codigo) VALUES("Tecnologia", "00001");
INSERT INTO grau(nome_grau, codigo) VALUES("Bacharel", "00021");
INSERT INTO grau(nome_grau, codigo) VALUES("Pos Graduação", "00231");
INSERT INTO grau(nome_grau, codigo) VALUES("Mestrado", "001321");
INSERT INTO grau(nome_grau, codigo) VALUES("Doutorado", "44121");
 
INSERT INTO curso(grau_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento) VALUES(1,"123", "Análise e Desenvolvimento de Sistemas", "ADS", 6, "S");
INSERT INTO curso(grau_id, codigo_curso,nome_curso, sigla_curso, qtd_semestre, fechamento) VALUES(2,"123",  "Processos Gerenciais", "PRG", 8, "S");
INSERT INTO curso(grau_id,codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento) VALUES(3,"123",  "Fisica", "FIS", 4, "S");
INSERT INTO curso(grau_id, codigo_curso,nome_curso, sigla_curso, qtd_semestre, fechamento) VALUES(4,"123",  "Computação Avançada", "CPA", 3, "B");
INSERT INTO curso(grau_id,codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento) VALUES(5,"123",  "Cura do Cancer", "CDC", 8, 'S');