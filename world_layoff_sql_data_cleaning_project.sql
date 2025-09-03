use world_layoff;

-- first view of data before starting
select * from layoffs;

-- creating satging table to preserve original data
create table layoffs_staging like layoffs;

-- inserting/copying data into staging table
insert layoffs_staging
select * from layoffs;

select * from layoffs_staging;

-- step-1.. removing duplicates if any
with duplicate_cte as 
(
select *,
row_number() over( partition by company, location, industry , total_laid_off , percentage_laid_off , `date` ,
stage , country , funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num>1;

select * from layoffs_staging where company = 'casper';

-- creating staging2 table to remove duplicate records
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

-- inserting records in staging2 table
insert into layoffs_staging2
select *,
row_number() over( partition by company, location, industry , total_laid_off , percentage_laid_off , `date` ,
stage , country , funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2
where row_num>1;
  
-- deleting duplicate records
DELETE FROM layoffs_staging2 WHERE row_num > 1;

-- dropping row_num column as duplicated are removed
Alter table layoffs_staging2 drop column row_num;


-- Step-2 .... Standardizing data
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company=trim(Company);

select distinct(industry)
from layoffs_staging2 order by 1;

-- cross checking before updating
select * from layoffs_staging2 where industry like 'Crypto%';

-- updating crypto and cryptocurrency to crypto
update layoffs_staging2
set industry='Crypto' where industry like 'Crypto%';

-- select * from layoffs_staging2;
select distinct(country)
from layoffs_staging2 order by 1;

-- fixing country name (some are united states & some with fullstop at end but same)
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country=trim(trailing '.' from country);


-- formatting date columns datatype from text to date
-- useful when doing time series visualizations n all
select `date` from layoffs_staging2;

update layoffs_staging2
set `date`= str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- handling null values
select * from layoffs_staging2 
where industry is null or industry = '' ;

select * from layoffs_staging2 where company like 'bally%';

select * from layoffs_staging2 t1 
join layoffs_staging2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry='')
and ( t2.industry not like '');

-- populating industry values where its null
update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company =t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry='')
and ( t2.industry not like '');

select * from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

select * from layoffs_staging2;

alter table layoffs_staging2 drop column row_num;

-- so now the data is cleaned and prepared for eda and visualization
-- removed duplicate records
-- standardized feilds like company,industry, country
-- changed the datatype of date from text to date datatype which will help in analysis
-- handled null values by populating some fields in industry and deleting some records where its not possible 
-- removed unwanted feilds like row_num,etc