# 📊 Projeto de Análise de Demissões (2020 - 2023) - MySQL

Este projeto analisa dados de demissões de grandes empresas no período de 2020 a 2023, utilizando MySQL para limpeza, transformação e análise exploratória dos dados.

## 🔹 Estrutura do Projeto

### 1️⃣ Data Cleaning Project (Limpeza e Padronização dos Dados)
A primeira etapa envolve a limpeza e padronização dos dados, dividida em quatro etapas:

#### 🧹 1. Remover Duplicadas
Criamos uma nova tabela para manter os dados originais e trabalhar na cópia:
```sql
CREATE TABLE layoffs_staging
LIKE layoffs;
INSERT layoffs_staging
SELECT * FROM layoffs;
```
Identificamos duplicatas particionando os dados:
```sql
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;
```
Utilizando CTEs para exibir apenas os dados duplicados:
```sql
WITH duplicate_cte AS (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
        stage, country, funds_raised_millions) AS row_num
    FROM layoffs_staging
)
SELECT * FROM duplicate_cte WHERE row_num > 1;
```
Criamos uma nova tabela para remover as duplicatas:
```sql
CREATE TABLE layoffs_staging2 (
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
);
```
Populamos a nova tabela:
```sql
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
    stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
```
Removemos as duplicatas:
```sql
DELETE FROM layoffs_staging2 WHERE row_num > 1;
```

#### 🔠 2. Padronizar os Dados
Removemos espaços extras na coluna `company`:
```sql
UPDATE layoffs_staging2 SET company = TRIM(company);
```

#### 🔎 3. Verificar Valores Nulos ou em Branco
Substituímos valores vazios por `NULL`:
```sql
UPDATE layoffs_staging2 SET industry = NULL WHERE industry = '';
```
Preenchemos valores nulos com base em registros existentes:
```sql
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;
```

#### 🗑 4. Remover Colunas Desnecessárias
Remover colunas desnecessárias melhora o desempenho da análise, especialmente para grandes volumes de dados.

---

### 2️⃣ Exploratory Data Analysis (Análise Exploratória)

#### 📈 Maior Número e Percentual de Demissões
```sql
SELECT MAX(total_laid_off), MAX(percentage_laid_off) FROM layoffs_staging2;
```

#### 📅 Demissões por Ano
```sql
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;
```

#### 📊 Progressão de Demissões ao Longo do Tempo
```sql
WITH Rolling_Total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `MONTH`
    ORDER BY 1
)
SELECT `MONTH`, total_, SUM(total_) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
```

#### 🏆 Ranking das 5 Empresas que Mais Demitiram por Ano
```sql
WITH Company_Year (company, years, total_laid_off) AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS (
    SELECT *,
    DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS rank_year
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT * FROM Company_Year_Rank WHERE rank_year <= 5;
```

## 📌 Conclusão
Este projeto demonstra o processo de limpeza e análise de dados de demissões utilizando MySQL. A limpeza garante que os dados estejam padronizados e prontos para análise, enquanto a exploração fornece insights sobre padrões de demissão ao longo dos anos.

📂 **Veja o código completo no repositório**

---

📷 **Imagens**

_(Inserir imagens aqui)_

