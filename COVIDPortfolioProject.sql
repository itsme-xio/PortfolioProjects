select * 
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select * 
--from PortfolioProject..CovidVaccinations
--order by 3,4

--select location, date, total_cases, new_cases, total_deaths, population
--from PortfolioProject..CovidDeaths
--order by 1,2

--Looking at Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract COVID in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states'
and continent is not null
order by 1,2

-- Looking at Total Cases vs Population
--Shows what population got COVID
select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%states'
order by 1,2

--Looking at Countries with Highest infection Rate compared to population
select location, population, max(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
group by location, population
order by PercentPopulationInfected desc

--Showing Countries with the Highest Death Count per Population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

--Let's break things down by continent

-- Showing continents with highest death count
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states'
where continent is not null
group by continent
order by TotalDeathCount desc


-- Global numbers
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(New_cases)*100
as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%states'
where continent is not null
group by date
order by 1,2

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(New_cases)*100
as DeathPercentage
from PortfolioProject..CovidDeaths
--where location like '%states'
where continent is not null
--group by date
order by 1,2


--Looking at Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(convert(int, vacc.new_vaccinations )) over (partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
	from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vacc
on dea.location = vacc.location	
	and dea.date = vacc.date
where dea.continent is not null
order by 2,3


-- use CTE
with PopvsVacc (continent,location, date, population, New_Vaccinations, RollingPeopleVaccinated)
as (
select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(convert(int, vacc.new_vaccinations )) over (partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
	from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vacc
on dea.location = vacc.location	
	and dea.date = vacc.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100
from PopvsVacc

--Temp Table
Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(continent nvarchar(255), location nvarchar(255), date datetime, population numeric,
new_vaccinations numeric, RollingPeopleVaccinated numeric)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(convert(int, vacc.new_vaccinations )) over (partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
	from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vacc
on dea.location = vacc.location	
	and dea.date = vacc.date
--where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated

--Creating View to store data for later visualizations

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(convert(int, vacc.new_vaccinations )) over (partition by dea.location order by dea.location,
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
	from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vacc
on dea.location = vacc.location	
	and dea.date = vacc.date
where dea.continent is not null
--order by 2,3


select * 
from PercentPopulationVaccinated



