# Settings - Clinic

Fields to be shown in UI:
- Name
- Phone No.
- Registration ID
- Address
  - Street Name
  - Building No.
  - Floor
  - City
  - Zip Code
- Working Days/Hours
  - Sunday
  - Monday
  - Tuesday
  - Wednesday
  - Thursday
  - Friday
  - Saturday

<br>

----------------------

- To view Clinic Info: `name`, `phone_num`, `registration_id`, `address`, `working_days_hours`.

  > GET: `clinic/info`

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "name": "New Clinic Name",
            "phone_num": "01221234567",
            "registration_id": "12345",
            "address": {
                "id": 165,
                "long": "31.123",
                "lat": "30.123",
                "city": "Cairo",
                "zip_code": "1111",
                "street": "St.",
                "building": "6",
                "floor": 1
            },
            "working_days_hours": "{'Monday': [{'end_hour': '19:30', 'start_hour': '12:00', 'patient_time': 15, 'shift_duration': 7.5, 'slots_available_for_booking': ['12:00 to 12:15', '12:15 to 12:30', '12:30 to 12:45', '12:45 to 13:00', '13:00 to 13:15', '13:15 to 13:30', '13:30 to 13:45', '13:45 to 14:00', '14:00 to 14:15', '14:15 to 14:30', '14:30 to 14:45', '14:45 to 15:00', '15:00 to 15:15', '15:15 to 15:30', '15:30 to 15:45', '15:45 to 16:00', '16:00 to 16:15', '16:15 to 16:30', '16:30 to 16:45', '16:45 to 17:00', '17:00 to 17:15', '17:15 to 17:30', '17:30 to 17:45', '17:45 to 18:00', '18:00 to 18:15', '18:15 to 18:30', '18:30 to 18:45', '18:45 to 19:00', '19:00 to 19:15', '19:15 to 19:30']}], 'Saturday': [{'end_hour': '19:30', 'start_hour': '12:00', 'patient_time': 30, 'shift_duration': 7.5, 'slots_available_for_booking': ['12:00 to 12:30', '12:30 to 13:00', '13:00 to 13:30', '13:30 to 14:00', '14:00 to 14:30', '14:30 to 15:00', '15:00 to 15:30', '15:30 to 16:00', '16:00 to 16:30', '16:30 to 17:00', '17:00 to 17:30', '17:30 to 18:00', '18:00 to 18:30', '18:30 to 19:00', '19:00 to 19:30']}, {'end_hour': '23:30', 'start_hour': '21:00', 'patient_time': 15, 'shift_duration': 2.5, 'slots_available_for_booking': ['21:00 to 21:15', '21:15 to 21:30', '21:30 to 21:45', '21:45 to 22:00', '22:00 to 22:15', '22:15 to 22:30', '22:30 to 22:45', '22:45 to 23:00', '23:00 to 23:15', '23:15 to 23:30']}]}"
        },
        "message": "Clinic Information retrieved successfully."
    }
    ```

- To update Clinic Info: `name`, `phone_num`, `registration_id`.
  > PUT: `clinic/info`

  **Request Body**
   ```json
  {
        "name": "Clinic Name",
        "phone_num": "01221234567",
        "registration_id": "12345"
  }
  ```

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "name": "Clinic Name",
            "phone_num": "01221234567",
            "registration_id": "12345"
        },
        "message": "Clinic information updated successfully."
  }
  ```
- List of cities API.
  > GET: `assets/city`

  **Response Message**
  ```json
  [
        {
            "label": "Cairo",
            "value": 1
        },
        {
            "label": "Giza",
            "value": 2
        },
        {
            "label": "Alexandria",
            "value": 3
        },
        {
            "label": "Hurghada",
            "value": 10
        },
        {
            "label": "Beni-Suef",
            "value": 11
        },
        {
            "label": "Minia",
            "value": 12
        },
        {
            "label": "Dakahlia",
            "value": 13
        },
        {
            "label": "Assuit",
            "value": 14
        },
        {
            "label": "Suez",
            "value": 15
        }
  ]
  ```

  <br>

----------------------

- Address Info: `id`, `long`, `lat`, `city`, `zip_code`, `street`, `building`, `floor`.
- `address_tag` to be implemented.

- To view Address Info:
  > GET: `clinic/address`

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "name": "Clinic Name",
            "address": {
                "id": 165,
                "long": "31.123",
                "lat": "30.123",
                "city": "Cairo",
                "zip_code": "1111",
                "street": "St.",
                "building": "6",
                "floor": 1
            }
        },
        "message": "Clinic's Address Info retrieved successfully."
  }
  ```
- The physician can update Clinic Address Info:
    > POST: `clinic/address`

    **Request Body**
    ```json
    {
        "address": {
            "zip_code": "1111",
            "building": "6",
            "street": "St.",
            "city": "Cairo",
            "lat": 30.123,
            "long": 31.123
        }
    }
    ```

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "name": "Clinic Name",
            "address": {
                "id": 188,
                "long": "31.123",
                "lat": "30.123",
                "city": "Cairo",
                "zip_code": "1111",
                "street": "St.",
                "building": "6",
                "floor": 1
            }
        },
        "message": "Clinic Address Information updated successfully."
    }
    ```
<br>

----------------------

- Working Days/Hours Info: `start_hour`, `end_hour`, `patient_time`. Those fields are to be provided for all week days.
- `start_hour` and `end_hour` are to be provided in 24-hour format.
- `patient_time` is to be provided in minutes.
- _Note_: Each day can have multiple working hours. (Multiple `start_hour` and `end_hour`)

- To add Working Days/Hours
  > POST: `clinic/working_days_hours`

  **Request Body**
  ```json
  {
        "working_days_hours": {
            "Saturday": [
                {
                    "start_hour": "12:00",
                    "end_hour": "19:30",
                    "patient_time": 30
                },
                {
                    "start_hour": "21:00",
                    "end_hour": "23:30",
                    "patient_time": 15
                }
            ],
            "Monday": [
                {
                    "start_hour": "12:00",
                    "end_hour": "19:30",
                    "patient_time": 15
                }
            ]
        }
  }
  ```
- _Note_: `shift_duration`, `slots_available_for_booking` are calculated if data is provided in the request body is valid.

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "name": "Clinic Name",
            "working_days_hours": {
                "Saturday": [
                    {
                        "start_hour": "12:00",
                        "end_hour": "19:30",
                        "patient_time": 30,
                        "shift_duration": 7.5,
                        "slots_available_for_booking": [
                            "12:00 to 12:30",
                            "12:30 to 13:00",
                            "13:00 to 13:30",
                            "13:30 to 14:00",
                            "14:00 to 14:30",
                            "14:30 to 15:00",
                            "15:00 to 15:30",
                            "15:30 to 16:00",
                            "16:00 to 16:30",
                            "16:30 to 17:00",
                            "17:00 to 17:30",
                            "17:30 to 18:00",
                            "18:00 to 18:30",
                            "18:30 to 19:00",
                            "19:00 to 19:30"
                        ]
                    },
                    {
                        "start_hour": "21:00",
                        "end_hour": "23:30",
                        "patient_time": 15,
                        "shift_duration": 2.5,
                        "slots_available_for_booking": [
                            "21:00 to 21:15",
                            "21:15 to 21:30",
                            "21:30 to 21:45",
                            "21:45 to 22:00",
                            "22:00 to 22:15",
                            "22:15 to 22:30",
                            "22:30 to 22:45",
                            "22:45 to 23:00",
                            "23:00 to 23:15",
                            "23:15 to 23:30"
                        ]
                    }
                ],
                "Monday": [
                    {
                        "start_hour": "12:00",
                        "end_hour": "19:30",
                        "patient_time": 15,
                        "shift_duration": 7.5,
                        "slots_available_for_booking": [
                            "12:00 to 12:15",
                            "12:15 to 12:30",
                            "12:30 to 12:45",
                            "12:45 to 13:00",
                            "13:00 to 13:15",
                            "13:15 to 13:30",
                            "13:30 to 13:45",
                            "13:45 to 14:00",
                            "14:00 to 14:15",
                            "14:15 to 14:30",
                            "14:30 to 14:45",
                            "14:45 to 15:00",
                            "15:00 to 15:15",
                            "15:15 to 15:30",
                            "15:30 to 15:45",
                            "15:45 to 16:00",
                            "16:00 to 16:15",
                            "16:15 to 16:30",
                            "16:30 to 16:45",
                            "16:45 to 17:00",
                            "17:00 to 17:15",
                            "17:15 to 17:30",
                            "17:30 to 17:45",
                            "17:45 to 18:00",
                            "18:00 to 18:15",
                            "18:15 to 18:30",
                            "18:30 to 18:45",
                            "18:45 to 19:00",
                            "19:00 to 19:15",
                            "19:15 to 19:30"
                        ]
                    }
                ]
            }
        },
        "message": "Clinic Working Hours updated successfully"
  }
  ```

- To view Clinic's Working Days/Hours:
  > GET: `clinic/working_days_hours`

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "name": "Clinic Name",
            "working_days_hours": {
                "Monday": [
                    {
                        "end_hour": "19:30",
                        "start_hour": "12:00",
                        "patient_time": 15,
                        "shift_duration": 7.5,
                        "slots_available_for_booking": [
                            "12:00 to 12:15",
                            "12:15 to 12:30",
                            "12:30 to 12:45",
                            "12:45 to 13:00",
                            "13:00 to 13:15",
                            "13:15 to 13:30",
                            "13:30 to 13:45",
                            "13:45 to 14:00",
                            "14:00 to 14:15",
                            "14:15 to 14:30",
                            "14:30 to 14:45",
                            "14:45 to 15:00",
                            "15:00 to 15:15",
                            "15:15 to 15:30",
                            "15:30 to 15:45",
                            "15:45 to 16:00",
                            "16:00 to 16:15",
                            "16:15 to 16:30",
                            "16:30 to 16:45",
                            "16:45 to 17:00",
                            "17:00 to 17:15",
                            "17:15 to 17:30",
                            "17:30 to 17:45",
                            "17:45 to 18:00",
                            "18:00 to 18:15",
                            "18:15 to 18:30",
                            "18:30 to 18:45",
                            "18:45 to 19:00",
                            "19:00 to 19:15",
                            "19:15 to 19:30"
                        ]
                    }
                ],
                "Saturday": [
                    {
                        "end_hour": "19:30",
                        "start_hour": "12:00",
                        "patient_time": 30,
                        "shift_duration": 7.5,
                        "slots_available_for_booking": [
                            "12:00 to 12:30",
                            "12:30 to 13:00",
                            "13:00 to 13:30",
                            "13:30 to 14:00",
                            "14:00 to 14:30",
                            "14:30 to 15:00",
                            "15:00 to 15:30",
                            "15:30 to 16:00",
                            "16:00 to 16:30",
                            "16:30 to 17:00",
                            "17:00 to 17:30",
                            "17:30 to 18:00",
                            "18:00 to 18:30",
                            "18:30 to 19:00",
                            "19:00 to 19:30"
                        ]
                    },
                    {
                        "end_hour": "23:30",
                        "start_hour": "21:00",
                        "patient_time": 15,
                        "shift_duration": 2.5,
                        "slots_available_for_booking": [
                            "21:00 to 21:15",
                            "21:15 to 21:30",
                            "21:30 to 21:45",
                            "21:45 to 22:00",
                            "22:00 to 22:15",
                            "22:15 to 22:30",
                            "22:30 to 22:45",
                            "22:45 to 23:00",
                            "23:00 to 23:15",
                            "23:15 to 23:30"
                        ]
                    }
                ]
            }
        },
        "message": "Clinic's Working Days Hours Info retrieved successfully."
  }
  ```

  <br>

  ----------------------