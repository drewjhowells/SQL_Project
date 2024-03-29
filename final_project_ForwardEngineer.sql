-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`degree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`degree` ;

CREATE TABLE IF NOT EXISTS `university`.`degree` (
  `degree_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `degree_name` VARCHAR(45) NOT NULL,
  `department_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`degree_id`),
  INDEX `fk_degree_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_degree_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `course_num` INT UNSIGNED NOT NULL,
  `course_credit` INT UNSIGNED NOT NULL,
  `course_code` VARCHAR(10) NOT NULL,
  `degree_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_degree1_idx` (`degree_id` ASC) VISIBLE,
  UNIQUE INDEX `course_code_UNIQUE` (`course_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_degree1`
    FOREIGN KEY (`degree_id`)
    REFERENCES `university`.`degree` (`degree_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(6) NOT NULL,
  `term_year` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_capacity` INT UNSIGNED NOT NULL,
  `section_number` INT UNSIGNED NOT NULL,
  `course_id` INT UNSIGNED NOT NULL,
  `term_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`person` ;

CREATE TABLE IF NOT EXISTS `university`.`person` (
  `person_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_fname` VARCHAR(45) NOT NULL,
  `person_lname` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(2) NULL,
  `dob` DATE NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`role` ;

CREATE TABLE IF NOT EXISTS `university`.`role` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `enrollment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_id` INT UNSIGNED NOT NULL,
  `person_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_person_occupation_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_enrollment_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_enrollment_occupation1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_occupation_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `university`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_occupation1`
    FOREIGN KEY (`role_id`)
    REFERENCES `university`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Base Tables (Department, Term, Occupation, Person)
INSERT INTO department (department_name) VALUES
('Computer Science and Engineering'),
('Mathematics'),
('Music');

INSERT INTO term (term_name, term_year) VALUES
('Fall', 2024),
('Winter', 2025);

INSERT INTO role (person_type) VALUES
('Teacher'),
('Student'),
('TA');

INSERT INTO person (person_fname, person_lname, gender, city, state, dob) 
VALUES 
    ('Marshall', 'Spence', 'M', 'Garland', 'TX', '2000-06-23'),
    ('Maria', 'Clark', 'F', 'Akron', 'OH', '2002-01-25'),
    ('Tracy', 'Woodward', 'F', 'Newark', 'NJ', '2002-10-04'),
    ('Erick', 'Woodward', 'M', 'Newark', 'NJ', '1998-08-05'),
    ('Lillie', 'Summers', 'F', 'Reno', 'NV', '1999-11-05'),
    ('Nellie', 'Marquez', 'F', 'Atlanta', 'GA', '2001-06-25'),
    ('Allen', 'Stokes', 'M', 'Bozeman', 'MT', '2004-09-16'),
    ('Josh', 'Rollins', 'M', 'Decatur', 'TN', '1998-11-28'),
    ('Isabel', 'Meyers', 'F', 'Rexburg', 'ID', '2003-05-15'),
    ('Kerri', 'Shah', 'F', 'Mesa', 'AZ', '2003-04-05');
INSERT INTO person (person_fname, person_lname) 
VALUES 
    ('Brady', 'Meyer'),
    ('Andy', 'Kipner'),
    ('Lucy', 'Fuller'),
    ('Adam', 'Woods'),
    ('Bryan', 'Drew');

-- Linking Tables (1. Degree, 2. Course, 3. Section, 4. Enrollment)

INSERT INTO degree (degree_name, department_id) VALUES
('Computer Science', 1),
('Web Design and Development', 1),
('Data Science', 2),
('Organ Performance', 3);

INSERT INTO course (course_name, course_num, course_credit, course_code, degree_id) 
VALUES 
    ('Parallelism and Concurrency', 251, 3, 'CSE', (SELECT degree_id FROM degree WHERE degree_name = 'Computer Science')),
    ('Web Frontend Development I', 231, 2, 'WDD', (SELECT degree_id FROM degree WHERE degree_name = 'Web Design and Development')),
    ('Calculus II', 113, 3, 'MATH', (SELECT degree_id FROM degree WHERE degree_name = 'Data Science')),
    ('Musicianship', 213, 4, 'MUSIC', (SELECT degree_id FROM degree WHERE degree_name = 'Organ Performance'));
;

INSERT INTO section (section_capacity, section_number, course_id, term_id) 
VALUES 
    (35, 1, (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = 251), (SELECT term_id FROM term WHERE term_name = 'Fall' AND term_year = 2024)),
    (30, 1, (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = 231), (SELECT term_id FROM term WHERE term_name = 'Fall' AND term_year = 2024)),
    (30, 2, (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = 231), (SELECT term_id FROM term WHERE term_name = 'Fall' AND term_year = 2024)),
    (45, 1, (SELECT course_id FROM course WHERE course_code = 'MATH' AND course_num = 113), (SELECT term_id FROM term WHERE term_name = 'Fall' AND term_year = 2024)),
    (25, 1, (SELECT course_id FROM course WHERE course_code = 'MUSIC' AND course_num = 213), (SELECT term_id FROM term WHERE term_name = 'Fall' AND term_year = 2024)),
    (35, 2, (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = 251), (SELECT term_id FROM term WHERE term_name = 'Winter' AND term_year = 2025)),
    (35, 3, (SELECT course_id FROM course WHERE course_code = 'CSE' AND course_num = 251), (SELECT term_id FROM term WHERE term_name = 'Winter' AND term_year = 2025)),
    (30, 1, (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = 231), (SELECT term_id FROM term WHERE term_name = 'Winter' AND term_year = 2025)),
    (40, 2, (SELECT course_id FROM course WHERE course_code = 'WDD' AND course_num = 231), (SELECT term_id FROM term WHERE term_name = 'Winter' AND term_year = 2025)),
    (25, 1, (SELECT course_id FROM course WHERE course_code = 'MUSIC' AND course_num = 213), (SELECT term_id FROM term WHERE term_name = 'Winter' AND term_year = 2025));

INSERT INTO enrollment (person_id, section_id, role_id)
VALUES
    ((SELECT person_id 
      FROM person 
      WHERE person_fname = 'Brady' 
      AND person_lname = 'Meyer'),
     (SELECT section_id FROM section s 
      INNER JOIN course c ON s.course_id = c.course_id 
      INNER JOIN term t ON s.term_id = t.term_id 
      WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' 
      AND CONCAT(course_code, ' ', course_num) = 'CSE 251' 
      AND section_number = 1),
     (SELECT role_id 
      FROM role 
      WHERE person_type = 'Teacher')),
    
    ((SELECT person_id FROM person WHERE person_fname = 'Brady' AND person_lname = 'Meyer'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Andy' AND person_lname = 'Kipner'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Andy' AND person_lname = 'Kipner'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Andy' AND person_lname = 'Kipner'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Andy' AND person_lname = 'Kipner'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Lucy' AND person_lname = 'Fuller'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MATH 113' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Adam' AND person_lname = 'Woods'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MUSIC 213' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Adam' AND person_lname = 'Woods'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'MUSIC 213' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Bryan' AND person_lname = 'Drew'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 3),
     (SELECT role_id FROM role WHERE person_type = 'Teacher')),

    ((SELECT person_id FROM person WHERE person_fname = 'Marshall' AND person_lname = 'Spence'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Marshall' AND person_lname = 'Spence'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Maria' AND person_lname = 'Clark'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MATH 113' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Tracy' AND person_lname = 'Woodward'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MATH 113' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Erick' AND person_lname = 'Woodward'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MUSIC 213' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Lillie' AND person_lname = 'Summers'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MATH 113' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Lillie' AND person_lname = 'Summers'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Fall 2024' AND CONCAT(course_code, ' ', course_num) = 'MUSIC 213' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'TA')),

    ((SELECT person_id FROM person WHERE person_fname = 'Nellie' AND person_lname = 'Marquez'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 3),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Allen' AND person_lname = 'Stokes'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Allen' AND person_lname = 'Stokes'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'TA')),

    ((SELECT person_id FROM person WHERE person_fname = 'Allen' AND person_lname = 'Stokes'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'MUSIC 213' AND section_number = 1),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Josh' AND person_lname = 'Rollins'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Isabel' AND person_lname = 'Meyers'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'WDD 231' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Student')),

    ((SELECT person_id FROM person WHERE person_fname = 'Kerri' AND person_lname = 'Shah'),
     (SELECT section_id FROM section s INNER JOIN course c ON s.course_id = c.course_id INNER JOIN term t ON s.term_id = t.term_id WHERE CONCAT(term_name, ' ', term_year) = 'Winter 2025' AND CONCAT(course_code, ' ', course_num) = 'CSE 251' AND section_number = 2),
     (SELECT role_id FROM role WHERE person_type = 'Student'));

