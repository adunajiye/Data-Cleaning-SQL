

	  -- Standardise Data Format
	  Select * from [dbo].['Housing Data$']

	  Select SaleDate, Convert(Date,Saledate)
	  From NashVilleHousing.[dbo].['Housing Data$']
	  
  Update ['Housing Data$']
  set SaleDate = Convert(Date,Saledate);

  ALTER  Table ['Housing Data$']
  add SalesDateConverted Date;

  Update ['Housing Data$']
  set SalesDateConverted  = Convert(Date,Saledate)

  Select * from ['Housing Data$']


    -- Populate PropertyAddress
	Select a.ParcelId,a.PropertyAddress,a.ParcelId,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
	from ['Housing Data$']a 
	Join ['Housing Data$'] b
	on a.ParcelID=b.ParcelID
	And a.[UniqueID ]<>b.[UniqueID ]
	where a.PropertyAddress is Null 

	Update a
	set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
	from  ['Housing Data$']a
	Join ['Housing Data$'] b
	on a.ParcelID=b.ParcelID
	And a.[UniqueID ]<>b.[UniqueID ]
	where a.PropertyAddress is Null 
 
  Select * from ['Housing Data$']
	
	--Breaking Out Address Into individual columns

	Select PropertyAddress
	from ['Housing Data$']

	Select SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as New_Address
	,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, Len(PropertyAddress)) as New_Address_1
	 from ['Housing Data$']

 ALTER  Table ['Housing Data$']
  add PropertyAddressSplit Nvarchar(255);

  Update ['Housing Data$']
  set PropertyAddressSplit  = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)
     
 Alter Table ['Housing Data$']
 Add  PropertyAddressCity Nvarchar(255);

 Update ['Housing Data$']
 set PropertyAddressCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, Len(PropertyAddress))

 Select * from  [dbo].['Housing Data$'] 

 Select *from  [dbo].['Housing Data$'] 


 -- Change Y and N to Yes and No In "sold as Vacant"
 Select Distinct(soldasvacant),Count(soldasvacant) as Count_Per_Sold_as_Vacant
 from ['Housing Data$']
 Group  By SoldAsVacant
 Order By 2

 Select soldasvacant
 ,Case  
 when soldasvacant=  'Y' then 'Yes'
 when soldasvacant = 'N' then 'No'
 else soldasvacant
 end 
 as New_Sold_as_Vacant
 from ['Housing Data$']


Update ['Housing Data$']
set  soldasvacant =
Case  
 when soldasvacant=  'Y' then 'Yes'
 when soldasvacant = 'N' then 'No'
 else soldasvacant
 end 

 


 --Remove Duplicates   
 with DemoCTE AS (
 select*,row_Number() Over(Partition By ParcelId
 ,[LegalReference]
 ,saleDate,saleprice
 Order By UniqueID)Row_Num
 from ['Housing Data$']
 -- Order By ParcelID
 )
 select * from DemoCTE
										
  -- Delete Un-used Columns
  Alter Table ['Housing Data$']
  Drop Column  PropertyAddress
  ,SaleDate
  ,SalePrice
  ,Legalreference
  ,TaxDistrict


  Select * from ['Housing Data$']

