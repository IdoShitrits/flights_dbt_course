with seat as (
		select aircraft_code,
		seat_no,
		fare_conditions
        from stg.seats
),
aircraft as (
		select aircraft_code,
		model -> 'en' as model_english,
		model -> 'ru' as model_russian,
		range		
		from stg.aircrafts_data 
)

select aircraft.*,
		seat.seat_no,
		seat.fare_conditions,
		case when aircraft.range >= 5600 then 'high' 
			 when aircraft.range < 5600 then 'low'
		end range_desc,
		'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from aircraft
	inner join seat on seat.aircraft_code = aircraft.aircraft_code