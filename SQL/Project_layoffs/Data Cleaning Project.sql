-- Data Cleaning
SELECT *
FROM layoffs;

-- ETAPAS:
-- 1. Remover os dados duplicados
-- 2. Padronizar os dados
-- 3. Verificar e tratar os dados nulos ou em branco
-- 4. Remover colunas desnecessárias

-- Criação de uma tabela deixando uma cópia dos dados originais
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Inserir os dados
INSERT layoffs_staging
SELECT * FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 1. Remover os dados duplicados
-- Paticionar os dados
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';


-- Criando outra tabelas com a coluna row_num para deletar as linhas duplicadas
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Populando a tabela layoffs_staging2
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Deletando as linhas duplicadas
DELETE
FROM layoffs_staging2
WHERE row_num > 1;