with n_tickets as (
	select ticket_no,
	book_ref,
	passenger_id,
	contact_data -> 'email' as email,
	contact_data -> 'phone' as phone
	from stg.tickets
),
n_bookings as (
	select *
	from stg.bookings 
)

select n_tickets.*,
	 n_bookings.book_date,
	 n_bookings.total_amount,
	'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}'::timestamp as dbt_time
from n_tickets
	inner join n_bookings on n_tickets.book_ref = n_bookings.book_ref
