select airport_code,
	airport_name -> 'en' as english_port_name,
	airport_name -> 'ru' as russian_port_name,
	city -> 'en' as english_city_name,
	city -> 'ru' as russian_city_name,
	coordinates,
	timezone,
	'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from stg.airports_data