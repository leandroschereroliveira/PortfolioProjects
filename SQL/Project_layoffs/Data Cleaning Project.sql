-- Data Cleaning
SELECT *
FROM layoffs;

-- ETAPAS:
-- 1. Remover os dados duplicados
-- 2. Padronizar os dados
-- 3. Verificar e tratar os dados nulos ou em branco
-- 4. Remover colunas ou linhas desnecessárias 

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

-- 2. Padronizar os dados
-- Verificando coluna company retirando os espaços em branco
SELECT DISTINCT company
FROM layoffs_staging2;

SELECT company,
TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- Coluna industry
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Padronizando a categoria Crypto
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Coluna location
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Encontrado alguns erros de codificação
SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Malm%';

UPDATE layoffs_staging2
SET location = 'Malmo'
WHERE location LIKE 'Malm%';

SELECT *
FROM layoffs_staging2
WHERE location LIKE '%sseldorf';

UPDATE layoffs_staging2
SET location = 'Dusseldorf'
WHERE location LIKE '%sseldorf';

SELECT *
FROM layoffs_staging2
WHERE location LIKE 'Floria%';

UPDATE layoffs_staging2
SET location = 'Florianopolis'
WHERE location LIKE 'Floria%';

-- Coluna country
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- Coluna date converter de texto para data
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- alterando a coluna para data
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. Verificar e tratar os dados nulos ou em branco

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- para dar certo é necessário transformar os valores em branco por nulos

UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 	t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- total_laid_off e percentage_laid_off, onde ambas as colunas estão nulas foram deletados 
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Excluindo a coluna row_num para diminuir o volume dos dados
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;