use portfolio_database;
describe coviddeaths;
select * from coviddeaths
order by 3, 4;
create schema portfoliodatabase;

select * from covidvacinations
order by 3, 4;

select location, date, total_cases, new_cases, total_deaths, population
 from coviddeaths
order by 1, 2;

#looking at total cases VS total deaths#

select location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as deathPercentage
 from coviddeaths
order by 1, 2;

#looking into where the specific location is# this shows the likelyhood of dying if you contract convid19
select location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as deathPercentage
 from coviddeaths
 where location like 'Norway%'
order by 1, 2;

#Looking at total cases vs total population# shows what % of the population has gotten covid
select location, date, population, total_cases, (total_cases/population)*100 as PercentOfPopulationINfected
 from coviddeaths
 where location like '%Nigeria%'
order by 1, 2;


#looking at countries with highest infection rate compared to population#

select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentOfPopulationINfected
 from coviddeaths
 where location like '%africa%'
 Group by location, population
order by PercentOfPopulationINfected desc;

#this is showing the countries with the highest death count per population#

select location, MAX(total_deaths ) as TotalDeathCount
 from coviddeaths
# where location like '%africa%'#
where continent is null
Group by location
order by TotalDeathCount desc;

select continent, location from coviddeaths;


#Lets break things up by continent#
Select continent, MAX(total_deaths) as TotalDeathCount
 from coviddeaths
# where location like '%africa%'#
where continent is not null
Group by continent
order by TotalDeathCount desc;


#GLOBAL NUMBERS#
select date, sum(new_cases) #,total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 from coviddeaths
 where continent is not null
 group by date
order by 1, 2;

#lets add the sum of new_deaths
select date, sum(new_cases), sum(CAST(new_deaths as unsigned)) 
 from coviddeaths
 where continent is not null
 group by date
order by 1, 2; #I had a little error initially in this query using CAST( AS INT) so i USED CAST(AS UNSIGNED)#

#Here lets try Death percentage globaly#
select date, sum(new_cases) as total_cases, sum(CAST(new_deaths as unsigned)) as total_deaths, sum(CAST(new_deaths as unsigned))/sum(new_cases)*100 as DeathPercentage
 from coviddeaths
 where continent is not null
 group by date
order by 1, 2;

#total cases all together (not splitting by date)#
select sum(new_cases) as total_cases, sum(CAST(new_deaths as unsigned)) as total_deaths, sum(CAST(new_deaths as unsigned))/sum(new_cases)*100 as DeathPercentage
 from coviddeaths
 where continent is not null
 #group by date#
order by 1, 2;

select *
from coviddeaths death
join covidvacinations vacine
 on death.location = vacine.location
 and death.date = vacine.date;
 
 #Looking at the total population VS vaccinations#
select death.continent, death.location, death.date, death.population, vacine.new_vaccinations
from coviddeaths death
join covidvacinations vacine
 on death.location = vacine.location
 and death.date = vacine.date
 where death.continent is not null
 order by 1,2,3;
 
 select * from covidvacinations;
 
 select death.continent, death.location, death.date, death.population, vacine.new_vaccinations
from coviddeaths death
join covidvacinations vacine
 on death.location = vacine.location
 and death.date = vacine.date
 where death.continent is not null
 order by 1,2,3;
 
