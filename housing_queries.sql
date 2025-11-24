/*

Cleaning Data in SQL Queries

*/

select *
from nashville_housing;


-- Populate Property Address data

select *
from nashville_housing
where propertyaddress is null
order by parcelid;

select a.parcelid,
       a.propertyaddress,
       b.parcelid,
       b.propertyaddress,
       coalesce(a.propertyaddress, b.propertyaddress)
from nashville_housing a
         join nashville_housing b
              on a.parcelid = b.parcelid and a.uniqueid <> b.uniqueid
where a.propertyaddress is null
;

update nashville_housing a
set propertyaddress = b.propertyaddress
from nashville_housing b
where a.parcelid = b.parcelid
  and a.uniqueid <> b.uniqueid
  and a.propertyaddress is null
;

-- Breaking out Address into Individual Columns (Address, City, State)

select propertyaddress
from nashville_housing
;

select substring(propertyaddress from 1 for position(',' in propertyaddress) - 1)                       as address1,
       substring(propertyaddress from position(',' in propertyaddress) + 1 for length(propertyaddress)) as address2
from nashville_housing
;

alter table nashville_housing
    add property_split_address varchar(255);
update nashville_housing
set property_split_address = substring(propertyaddress from 1 for position(',' in propertyaddress) - 1);

select owneraddress,
       split_part(owneraddress, ',', 1),
       split_part(owneraddress, ',', 2),
       split_part(owneraddress, ',', 3)
from nashville_housing;

alter table nashville_housing
    add owner_split_address varchar(255);
update nashville_housing
set owner_split_address = split_part(owneraddress, ',', 1);

alter table nashville_housing
    add owner_split_city varchar(255);
update nashville_housing
set owner_split_city = split_part(owneraddress, ',', 2);

alter table nashville_housing
    add owner_split_state varchar(255);
update nashville_housing
set owner_split_state = split_part(owneraddress, ',', 3);

-- Change Y and N to Yes and No in "Sold as Vacant" field
select distinct(soldasvacant), count(soldasvacant)
from nashville_housing
group by soldasvacant;

select soldasvacant,
       case
           when soldasvacant = 'Y' then 'Yes'
           when soldasvacant = 'N' then 'No'
           else soldasvacant end
from nashville_housing;

update nashville_housing
set soldasvacant = case
                       when soldasvacant = 'Y' then 'Yes'
                       when soldasvacant = 'N' then 'No'
                       else soldasvacant end;

-- Remove Duplicates

with rownum_cte as (select *,
                           row_number()
                           over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference order by uniqueid) row_num
                    from nashville_housing)
select *
from rownum_cte
where row_num > 1;

with rownum_cte as (select *,
                           row_number()
                           over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference order by uniqueid) row_num
                    from nashville_housing)
delete
from nashville_housing h
    using rownum_cte r
where h.uniqueid = r.uniqueid
  and r.row_num > 1;

-- Delete Unused Columns

alter table nashville_housing
    drop column owneraddress,
    drop column propertyaddress,
    drop column taxdistrict;

select *
from nashville_housing;