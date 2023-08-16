with tf as (
		select ticket_no,
				flight_id,
				fare_conditions,
				amount
		from stg.ticket_flights
),
bp as (
		select ticket_no,
				flight_id,
				boarding_no,
				seat_no
		from stg.boarding_passes 
)

select tf.*,
		bp.boarding_no,
		bp.seat_no,
		'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from tf inner join bp
	on tf.ticket_no = bp.ticket_no