SELECT 
	unique_id, parcel_id, land_use, property_address, sale_date, sale_price, legal_reference, sold_as_vacant, owner_name, owner_addres, acreage, tax_discrict, land_value, building_value, total_value, year_built, bedrooms, full_bath, half_bath
FROM portfolio.nh;

--standardisation of the date format



alter table	portfolio.nh 
alter column sale_date type date using sale_date::date;

-- property_address null substitution by checking parcel_id


with addresses_fixed as (
    select  
    	a.unique_id, a.parcel_id,
        coalesce (a.property_address, b.property_address) AS resolved_address
    from portfolio.nh a 
    join portfolio.nh b
    on a.parcel_id = b.parcel_id 
    and  a.unique_id <> b.unique_id 
    where  a.property_address is null
)
update portfolio.nh n
set property_address = ra.resolved_address
from addresses_fixed ra
where n.unique_id = ra.unique_id;

-- breaking property adress into individual columns



select property_address 
from portfolio.nh n 

select  
    property_address, 
    substring(property_address, 1 , position(',' in property_address) - 1) as adress, 
    substring(property_address, position(',' in property_address) + 1, length(property_address)) as adress2
from 
    portfolio.nh n 
    
alter table	portfolio.nh 
	add column proprerty_split_address varchar,
	add column proprerty_split_city varchar;

update portfolio.nh 
set proprerty_split_address = substring(property_address, 1 , position(',' in property_address) - 1),
 	proprerty_split_city = substring(property_address, position(',' in property_address) + 1, length(property_address));

 
 -- the same with owner adress
 
 
 
 select 
 	split_part(owner_addres,',',1),
 	split_part(owner_addres,',',2),
 	split_part(owner_addres,',',3)
 	
 from public.nh n 

 alter table	public.nh 
	add column owner_split_addres varchar,
	add column owner_split_city varchar,
	add column owner_split_state varchar;

update public.nh 
set 
	owner_split_addres = split_part(owner_addres,',',1),
	owner_split_city = split_part(owner_addres,',',2),
	owner_split_state = split_part(owner_addres,',',3);
select * from public.nh

-- unification of data 



select distinct (sold_as_vacant) as data_values, count(sold_as_vacant)
from portfolio.nh n 
group by data_values;

select distinct (sold_as_vacant), 
		case 
			when sold_as_vacant = 'Y' then 'Yes'
			when sold_as_vacant = 'N' then 'No'
			else sold_as_vacant 
		end
from portfolio.nh n  

update portfolio.nh n
set sold_as_vacant = case 
						when sold_as_vacant = 'Y' then 'Yes'
						when sold_as_vacant = 'N' then 'No'
						else sold_as_vacant 
					end;
	
-- remowing duplicates (for the purpose of demonstrating the process )
with remove_duplicates as (
	select unique_id,
		row_number() over(
			partition by parcel_id,
						 property_address,
						 sale_price,
						 sale_date,
						 legal_reference
						 ORDER BY
						 unique_id
	) as row_num
	from portfolio.nh n 
	
	
)
delete  
from portfolio.nh 
where unique_id in (
	select unique_id
	from remove_duplicates
	where row_num > 1
);


-- delete unused colums


alter table portfolio.nh 
drop column owner_addres, 
drop column tax_discrict,
drop column property_address

select  column_name 
from information_schema.columns 
where  table_name = 'nh' 
and  table_schema = 'public';

select * from portfolio.nh n 
				
		
				
				
				
