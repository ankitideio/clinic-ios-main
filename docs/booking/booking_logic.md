# Booking Logic

This whitepaper explains how the booking functionality should work, for both Patient and Physician.

* Patient should get a list of physicians, mainly filtered by `city` & `specialty`, where he can choose from. For each physician the basic info will be viewed e.g. `physician__full_name`, `physician__qualifications`, `clinic__working_days_hours`, `clinic__address`, `clinic__phone_num`

* According to the available slots i.e. `physician__available_slots`, the patient can then send a booking request to the physician, and the physician and/or assistant can simply accept or decline the request.

* In the *Patient App*, there will be a list showing:
  * All booking requests
  * Its status, whether confirmed or declined.
  * Physician Name
  * Physician Specialty

* In the *Clinic App*, a confirmed request will reflected in the Calendar under the corresponding date & time.
There will be a separate page for pending requests. This is where the action of acceptance or declining will take place.


<br>

----------------------

## Patient

- Listing all physicians, and filtering them by `city` and `specialty`.
    > GET

- Checking for available booking slots for each and every physician.
    > GET

- Sending a booking request.
    > POST


- Another listing of all previous bookings done by the patient. Only `physician__full_name`, `physician__specialty`, and `status` are to be shown.
    > GET


<br>

----------------------

## Physician

- Physician/Assistant shall be able to view all booking requests.
    > GET

- Physician/Assistant shall be able to accept/decline any booking requests.
    > PUT

- A possibility to automatically accept booking requests, in case the physician previously selected this (To Be Implemented).
    > GET

- Confirmed bookings shall reflect in calendar view in the Clinic App (To Be Implemented).
    > GET
    


<br>


----------------------

