# Booking API Documentation - Dentist APIs

You find all the APIs related to Dentist in `dentist/api/views/booking.py`

There are 3 APIs related to Dentist.

<br>

----------------------

## 1- Upcoming Booking

  > GET: `api/dentist/<int:dentist_id>/upcoming_bookings`
- Possible Parameters: status (pending,completed,confirmed,canceled)
- If “status=pending” then it returns the upcoming booking with pending - status in the next seven days
- If there are no status parameter it will return all upcoming booking in the next seven days
- It must be called by Dentist or Assistant only

<br>

----------------------

## 2- All Booking

> GET: `api/dentist/<int:dentist_id>/all_bookings`
- Possible Parameters: status (pending,completed,confirmed,canceled)
- If “status=pending” then it returns all booking with pending status
- If there are no status parameter it will return all booking
- It must be called by Dentist or Assistant only

<br>

----------------------

## 3- Available Booking Slots

  > GET: `api/dentist/<int:dentist_id>/available_slots`

- It supposed to return the available booking slots in the next seven days
- First it checks the clinic working hours
- Secondly it checks the booked time for the dentist and exclude both of them
- I assume that each visit is 30 min long
- It supports clinic with multiple shifts in one day
- It must be called by Dentist or Assistant only

Expected Response:
 ```json
{
    "success": true,
    "data": [
        {
            "booking_date": "2021-05-25",
            "avaliable_booking_time": [
                "09:00:00",
                "09:30:00",
                "10:00:00",
                "10:30:00",
                "11:00:00",
            ]
        },
        {
            "booking_date": "2021-05-26",
            "avaliable_booking_time": [
                "09:00:00",
                "09:30:00",
                "10:00:00",
                "10:30:00",
                "11:00:00",
            ]
        }
    ]
}
 
 ```
