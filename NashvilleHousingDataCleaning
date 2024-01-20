select * from PortfolioProject.dbo.NashvilleHousing

------------------------------
--Standardize Date Format-----
select SaleDateConverted, convert(date, SaleDate)
from PortfolioProject.dbo.NashvilleHousing

update NashvilleHousing
set SaleDate = convert(date, SaleDate)

alter table NashvilleHousing
add SaleDateConverted Date

update NashvilleHousing
set SaleDateConverted = convert(date, SaleDate)

--------------------------------------------
------Populate Property Address Data--------

select *
from PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is NULL
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b 
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b 
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-----------------------------------------------------
--- Breaking Out Address into Individual Columns ----
--------------( Address, City, State)----------------
select PropertyAddress
from PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is NULL
--order by ParcelID

select
substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress )) as City
from PortfolioProject.dbo.NashvilleHousing


alter table NashvilleHousing
add PropertySplitAddress Nvarchar(255)

update NashvilleHousing
set PropertySplitAddress = substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table NashvilleHousing
add PropertySplitCity Nvarchar(255)

update NashvilleHousing
set PropertySplitCity = substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 ,LEN(PropertyAddress))

select *
from PortfolioProject.dbo.NashvilleHousing

select OwnerAddress
from PortfolioProject.dbo.NashvilleHousing

select PARSENAME(replace(OwnerAddress, ',', '.') ,3),
PARSENAME(replace(OwnerAddress, ',', '.') ,2),
PARSENAME(replace(OwnerAddress, ',', '.') ,1)
from PortfolioProject.dbo.NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(255)

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress, ',', '.') ,3)

alter table NashvilleHousing
add OwnerSplitCIty nvarchar(255)

update NashvilleHousing
set OwnerSplitCity = PARSENAME(replace(OwnerAddress, ',', '.') ,2)

alter table NashvilleHousing
add OwnerSplitState nvarchar(255)

update NashvilleHousing
set OwnerSplitState = PARSENAME(replace(OwnerAddress, ',', '.') ,1)


----------------------------------------------------------
----Change Y and N to Yes and No in SoldAsVacant field----

select distinct(SoldAsVacant), count(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end

from PortfolioProject.dbo.NashvilleHousing

update NashvilleHousing
set SoldAsVacant =  case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end


----------------------------------------------------------------
------------------- Removing Duplicates-------------------------
--with RowNumCTE as(
--select *
--, ROW_NUMBER()over (
--		partition by ParcelID,
--					PropertyAddress,
--					SalePrice,
--					SaleDate,
--					LegalReference
--					order by 
--						UniqueID
--					 ) row_num
					
--from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
--)
--delete
--from RowNumCTE
--where row_num >1
--order by PropertyAddress

with RowNumCTE as(
select *
, ROW_NUMBER()over (
		partition by ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
					order by 
						UniqueID
					 ) row_num
					
from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
select *
from RowNumCTE
where row_num >1

------------------------------------------------------
------------- Delete Unused Columns-------------------

select *
from PortfolioProject.dbo.NashvilleHousing

alter table PortfolioProject.dbo.NashvilleHousing
drop column PropertyAddress, OwnerAddress, TaxDistrict


alter table PortfolioProject.dbo.NashvilleHousing
drop column SaleDate
