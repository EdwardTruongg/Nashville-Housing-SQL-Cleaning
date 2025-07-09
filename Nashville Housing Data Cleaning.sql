SELECT * 
FROM PortfolioProject.dbo.NashvilleHousing


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Standarize Data Format

UPDATE NashvilleHousing
SET SaleDate = CONVERT(DATE,SaleDate)

-- OR

ALTER TABLE NashvilleHousing
ADD SalesDateConverted DATE;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE,SaleDate)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Populate Property Adress Data

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Breaking out adress into Individual Columns (Adress, City, State)
SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
--ORDER BY ParcelID

SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 ) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress)) AS Address

FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1 , LEN(PropertyAddress)) 


SELECT *
FROM PortfolioProject.dbo.Nashvillehousing




SELECT OwnerAddress
FROM PortfolioProject.dbo.Nashvillehousing

SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM PortfolioProject.dbo.Nashvillehousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2) 

ALTER TABLE NashvilleHousing
ADD OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Changing 1 and 0 into Yes and No in "Sold as Vacabt" field
SELECT DISTINCT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing


SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 1 THEN 'Yes'
		 WHEN SoldAsVacant = 0 THEN 'No'
		 ELSE CAST(SoldAsVacant AS VARCHAR)
		 END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE PortfolioProject.dbo.NashvilleHousing
	SET SoldAsVacant = CASE WHEN SoldAsVacant = 1 THEN 'Yes'
		 WHEN SoldAsVacant = 0 THEN 'No'
		 ELSE CAST(SoldAsVacant AS VARCHAR)
		 END

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Removing Duplicates
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
						UniqueID
					) row_num
FROM PortfolioProject.dbo.NashvilleHousing
--ORDER BY ParcelID
)

Delete 
FROM RowNumCTE
WHERE Row_num > 1


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
