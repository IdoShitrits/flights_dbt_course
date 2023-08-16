with diffs as (
select flight_id,
		flight_no,
		scheduled_departure,
		scheduled_arrival,
		departure_airport,
		arrival_airport,
		status,
		aircraft_code,
		actual_departure,
		actual_arrival,
    EXTRACT(EPOCH FROM (actual_arrival - actual_departure)) / 3600 AS flight_duration,
    EXTRACT(EPOCH FROM (scheduled_arrival - scheduled_departure)) / 3600 AS flight_duration_expected
FROM
    stg.flights
)

select *,
		case when flight_duration_expected > flight_duration then 'longer'
   			 when flight_duration_expected < flight_duration then 'shorter'
   			 when flight_duration_expected = flight_duration then 'as expected'
			 else null
   		end duration_desc,
		'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from diffs