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
-- Table `horario`.`area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`area` ;

CREATE TABLE IF NOT EXISTS `horario`.`area` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `nome_area` VARCHAR(50) NOT NULL,
  `codigo` CHAR(5) NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `horario`.`pessoa` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `prontuario` CHAR(6) NOT NULL,
  `senha` CHAR(64) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`docente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`docente` ;

CREATE TABLE IF NOT EXISTS `horario`.`docente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT(11) NOT NULL,
  `area_id` SMALLINT(6) NOT NULL,
  `nascimento` DATE NOT NULL,
  `ingresso_campus` DATE NOT NULL,
  `ingresso_ifsp` DATE NOT NULL,
  `regime` CHAR(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_docente_area1_idx` (`area_id` ASC),
  INDEX `fk_docente_pessoa1_idx` (`pessoa_id` ASC),
  CONSTRAINT `fk_docente_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `horario`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `horario`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`modalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`modalidade` ;

CREATE TABLE IF NOT EXISTS `horario`.`modalidade` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome_modalidade` VARCHAR(50) NOT NULL,
  `codigo` INT(11) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`curso` ;

CREATE TABLE IF NOT EXISTS `horario`.`curso` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `docente_id` INT(11) NULL DEFAULT NULL,
  `modalidade_id` TINYINT(4) NOT NULL,
  `codigo_curso` CHAR(5) NOT NULL,
  `nome_curso` VARCHAR(75) NOT NULL,
  `sigla_curso` CHAR(3) NOT NULL,
  `qtd_semestre` TINYINT(2) NOT NULL,
  `fechamento` CHAR(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_curso_modalidade1_idx` (`modalidade_id` ASC),
  INDEX `fk_curso_docente1_idx` (`docente_id` ASC),
  CONSTRAINT `fk_curso_docente1`
    FOREIGN KEY (`docente_id`)
    REFERENCES `horario`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_modalidade1`
    FOREIGN KEY (`modalidade_id`)
    REFERENCES `horario`.`modalidade` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
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
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`disciplina` ;

CREATE TABLE IF NOT EXISTS `horario`.`disciplina` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `curso_id` SMALLINT(6) NOT NULL,
  `tipo_sala_id` TINYINT(4) NOT NULL,
  `nome_disciplina` VARCHAR(50) NOT NULL,
  `modulo` TINYINT(2) NOT NULL,
  `sigla_disciplina` CHAR(5) NOT NULL,
  `qtd_professor` TINYINT(1) NOT NULL,
  `qtd_aulas` TINYINT(2) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
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
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`periodo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`periodo` ;

CREATE TABLE IF NOT EXISTS `horario`.`periodo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` CHAR(6) NOT NULL,
  `ativo` CHAR(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`turno` ;

CREATE TABLE IF NOT EXISTS `horario`.`turno` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome_turno` VARCHAR(25) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_turno_UNIQUE` (`nome_turno` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`turma` ;

CREATE TABLE IF NOT EXISTS `horario`.`turma` (
  `id` INT(11) NOT NULL,
  `disciplina_id` SMALLINT(6) NOT NULL,
  `periodo_id` INT(11) NOT NULL,
  `turno_id` TINYINT(4) NOT NULL,
  `qtd_alunos` INT(11) NOT NULL,
  `dp` TINYINT(1) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_disciplina_has_periodo_periodo1_idx` (`periodo_id` ASC),
  INDEX `fk_disciplina_has_periodo_disciplina1_idx` (`disciplina_id` ASC),
  INDEX `fk_disciplinas_oferecidas_turno1_idx` (`turno_id` ASC),
  CONSTRAINT `fk_disciplina_has_periodo_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `horario`.`disciplina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_has_periodo_periodo1`
    FOREIGN KEY (`periodo_id`)
    REFERENCES `horario`.`periodo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplinas_oferecidas_turno1`
    FOREIGN KEY (`turno_id`)
    REFERENCES `horario`.`turno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`fpa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`fpa` ;

CREATE TABLE IF NOT EXISTS `horario`.`fpa` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `docente_id` INT(11) NOT NULL,
  `periodo_id` INT(11) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fpa_docente1_idx` (`docente_id` ASC),
  INDEX `fk_fpa_periodo1_idx` (`periodo_id` ASC),
  CONSTRAINT `fk_fpa_docente1`
    FOREIGN KEY (`docente_id`)
    REFERENCES `horario`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fpa_periodo1`
    FOREIGN KEY (`periodo_id`)
    REFERENCES `horario`.`periodo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`horario` ;

CREATE TABLE IF NOT EXISTS `horario`.`horario` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `inicio` TIME NOT NULL,
  `fim` TIME NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`disponibilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`disponibilidade` ;

CREATE TABLE IF NOT EXISTS `horario`.`disponibilidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fpa_id` INT(11) NOT NULL,
  `horario_id` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fpa_has_horario_horario1_idx` (`horario_id` ASC),
  INDEX `fk_fpa_has_horario_fpa1_idx` (`fpa_id` ASC),
  CONSTRAINT `fk_fpa_has_horario_fpa1`
    FOREIGN KEY (`fpa_id`)
    REFERENCES `horario`.`fpa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fpa_has_horario_horario1`
    FOREIGN KEY (`horario_id`)
    REFERENCES `horario`.`horario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`preferencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`preferencia` ;

CREATE TABLE IF NOT EXISTS `horario`.`preferencia` (
  `fpa_id` INT(11) NOT NULL,
  `turma_id` INT(11) NOT NULL,
  `ordem` INT(11) NOT NULL,
  PRIMARY KEY (`fpa_id`, `turma_id`),
  INDEX `fk_disciplina_has_fpa_fpa1_idx` (`fpa_id` ASC),
  INDEX `fk_preferencias_disciplinas_oferecidas1_idx` (`turma_id` ASC),
  CONSTRAINT `fk_disciplina_has_fpa_fpa1`
    FOREIGN KEY (`fpa_id`)
    REFERENCES `horario`.`fpa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preferencias_disciplinas_oferecidas1`
    FOREIGN KEY (`turma_id`)
    REFERENCES `horario`.`turma` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`tipo` ;

CREATE TABLE IF NOT EXISTS `horario`.`tipo` (
  `id` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NOT NULL,
  `deletado_em` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`tipo_pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`tipo_pessoa` ;

CREATE TABLE IF NOT EXISTS `horario`.`tipo_pessoa` (
  `tipo_id` TINYINT(4) NOT NULL,
  `pessoa_id` INT(11) NOT NULL,
  PRIMARY KEY (`tipo_id`, `pessoa_id`),
  INDEX `fk_tipo_has_pessoa_pessoa1_idx` (`pessoa_id` ASC),
  INDEX `fk_tipo_has_pessoa_tipo1_idx` (`tipo_id` ASC),
  CONSTRAINT `fk_tipo_has_pessoa_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `horario`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_has_pessoa_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `horario`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`turno_horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`turno_horario` ;

CREATE TABLE IF NOT EXISTS `horario`.`turno_horario` (
  `turno_id` TINYINT(4) NOT NULL,
  `horario_id` TINYINT(4) NOT NULL,
  PRIMARY KEY (`turno_id`, `horario_id`),
  INDEX `fk_turno_has_horario_horario1_idx` (`horario_id` ASC),
  INDEX `fk_turno_has_horario_turno1_idx` (`turno_id` ASC),
  CONSTRAINT `fk_turno_has_horario_turno1`
    FOREIGN KEY (`turno_id`)
    REFERENCES `horario`.`turno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turno_has_horario_horario1`
    FOREIGN KEY (`horario_id`)
    REFERENCES `horario`.`horario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `horario`.`atribuicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario`.`atribuicao` ;

CREATE TABLE IF NOT EXISTS `horario`.`atribuicao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `docente_id` INT(11) NOT NULL,
  `turma_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_docente_has_turma_turma1_idx` (`turma_id` ASC),
  INDEX `fk_docente_has_turma_docente1_idx` (`docente_id` ASC),
  CONSTRAINT `fk_docente_has_turma_docente1`
    FOREIGN KEY (`docente_id`)
    REFERENCES `horario`.`docente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_docente_has_turma_turma1`
    FOREIGN KEY (`turma_id`)
    REFERENCES `horario`.`turma` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Inserção de dados
-- -----------------------------------------------------

INSERT INTO tipo(nome) VALUES ('Administrador'), ('CRA'), ('DAE'), ('Docente');

INSERT INTO tipo_sala(id, nome_tipo_sala, descricao_tipo_sala) VALUES(1, "Teorica", "Mesas e Cadeiras");
INSERT INTO tipo_sala(id, nome_tipo_sala, descricao_tipo_sala) VALUES(2, "Pratica", "Computadores");
INSERT INTO tipo_sala(id, nome_tipo_sala, descricao_tipo_sala) VALUES(3, "Hibrida", "Mesas, cadeiras e computadores");
INSERT INTO tipo_sala(id, nome_tipo_sala, descricao_tipo_sala) VALUES(4, "Auditorio", "Apresentacoes");
INSERT INTO tipo_sala(id, nome_tipo_sala, descricao_tipo_sala) VALUES(5, "VideoConferencia", "Videoconferencias ao vivo");

INSERT INTO modalidade(id, nome_modalidade, codigo) VALUES(1, "Tecnologia", "00001");
INSERT INTO modalidade(id, nome_modalidade, codigo) VALUES(2, "Bacharel", "00021");
INSERT INTO modalidade(id, nome_modalidade, codigo) VALUES(3, "Pos Graduação", "00231");
INSERT INTO modalidade(id, nome_modalidade, codigo) VALUES(4, "Mestrado", "001321");
INSERT INTO modalidade(id, nome_modalidade, codigo) VALUES(5, "Doutorado", "44121");

INSERT INTO curso(id, modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
    VALUES(1, 1, 111, "Análise e Desenvolvimento de Sistemas", "ADS", 6, "B");
INSERT INTO curso(id, modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
    VALUES(2, 2, 222, "Processos Gerenciais", "PRG", 8, "S");
INSERT INTO curso(id, modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
    VALUES(3, 3, 333, "Fisica", "FIS", 4, "S");
INSERT INTO curso(id, modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
    VALUES(4, 4, 444, "Computação Avançada", "CPA", 3, "B");
INSERT INTO curso(id, modalidade_id, codigo_curso, nome_curso, sigla_curso, qtd_semestre, fechamento)
    VALUES(5, 5, 544, "Cura do Cancer", "CDC", 8, "B");

INSERT INTO disciplina(id, curso_id, tipo_sala_id, nome_disciplina, sigla_disciplina, qtd_professor, qtd_aulas, modulo)
    VALUES(1, 1, 5, "Análise de Sistemas", "ADS", 2, 4, 1);
INSERT INTO disciplina(id, curso_id, tipo_sala_id, nome_disciplina, sigla_disciplina, qtd_professor, qtd_aulas, modulo)
    VALUES(2, 2, 4, "Matemática", "MAT", 1, 6, 2);
INSERT INTO disciplina(id, curso_id, tipo_sala_id, nome_disciplina, sigla_disciplina, qtd_professor, qtd_aulas, modulo)
    VALUES(3, 3, 3, "Fisica Avancada", "FSA", 1, 8, 3);
INSERT INTO disciplina(id, curso_id, tipo_sala_id, nome_disciplina, sigla_disciplina, qtd_professor, qtd_aulas, modulo)
    VALUES(4, 4, 2, "Hardware", "HDW", 2, 2, 4);
INSERT INTO disciplina(id, curso_id, tipo_sala_id, nome_disciplina, sigla_disciplina, qtd_professor, qtd_aulas, modulo)
    VALUES(5, 5, 1, "Medicina", "MED", 2, 2, 5);

INSERT INTO turno(id, nome_turno) VALUES(1, "Matutino");
INSERT INTO turno(id, nome_turno) VALUES(2, "Vespertino");
INSERT INTO turno(id, nome_turno) VALUES(3, "Noturno");
INSERT INTO turno(id, nome_turno) VALUES(4, "Integral");
INSERT INTO turno(id, nome_turno) VALUES(5, "Diário");

INSERT INTO horario(id, inicio, fim) VALUES(1, '9:10:00', '10:00');
INSERT INTO horario(id, inicio, fim) VALUES(2, '13:10:00', '14:00');
INSERT INTO horario(id, inicio, fim) VALUES(3, '20:10:00', '21:00');
INSERT INTO horario(id, inicio, fim) VALUES(4, '9:10:00', '10:00');
INSERT INTO horario(id, inicio, fim) VALUES(5, '10:10:00', '20:00');

INSERT INTO turno_horario(turno_id, horario_id) VALUES(1, 1);
INSERT INTO turno_horario(turno_id, horario_id) VALUES(1, 2);

INSERT INTO area(id, codigo, nome_area) VALUES(1, "12345", "Informática");

INSERT INTO pessoa(id, nome, prontuario, senha, email) VALUES(1, "Usuario", "151515", "123456", "email@ifsp.edu");
INSERT INTO pessoa(id, nome, prontuario, senha, email) VALUES(2, "Usuario", "151521", "123456", "joao@ifsp.edu");

INSERT INTO docente(id, pessoa_id, area_id, nascimento, ingresso_campus, ingresso_ifsp, regime) VALUES(1, 1, 1, "1996/08/11", "2007/08/11", "2007/08/11", 1);
