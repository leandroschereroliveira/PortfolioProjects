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
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;