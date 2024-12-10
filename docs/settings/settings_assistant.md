# Settings - Assistant

- The physician can add Assistant User. We shall consider 2 subsections here: personal info, and account info.
- Personal info: `full_name`, `mobile`, `national_id`.
- Account info: `email`, `password`.

    > POST: `clinic/<uuid:clinic_uuid>/assistant/`

    **Request Body**
    ```json
    {
        "user_data": {
            "mobile": "01005171551",
            "email": "assistant1@lnkr.com",
            "password": "Test_test1",
            "national_id": "29502231234567"
        },
        "assistant_data": {
            "full_name": "Mohamed Ahmed",
            "clinic_uuid":"f243ef97-542c-4603-b1d2-3d9a5b7d08c1"
        }
    }
    ```

    **Response Body**
    ```json
    {
        "success": true,
        "data": {
            "id": 184,
            "full_name": "Mohamed Ahmed",
            "clinic_name": "Clinic Name",
            "clinic_uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "national_id": "29502231234567",
            "mobile": "01005171551",
            "email": "assistant1@lnkr.com",
            "dentist_id": 53
        },
        "message": "Assistant created successfully"
    }
    ```

------

- All Assistants can also be listed with their info: `id`, `full_name`, `clinic_name`, `clinic_uuid`, `national_id`, `mobile`, `email`, `dentist_id` .
  > GET: `clinic/<uuid:clinic_uuid>/assistant/`

    **Response Body**
  ```json
  {
        "success": true,
        "data": [
            {
                "id": 182,
                "full_name": "Karim",
                "clinic_name": "Clinic Name",
                "clinic_uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
                "national_id": "20202021233747",
                "mobile": "01005171551",
                "email": "Jaleel.Johns10@yahoo.com",
                "dentist_id": 53
            },
            {
                "id": 184,
                "full_name": "Mohamed Ahmed",
                "clinic_name": "Clinic Name",
                "clinic_uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
                "national_id": "29502231234567",
                "mobile": "01005171551",
                "email": "assistant1@lnkr.com",
                "dentist_id": 53
            }
        ],
        "message": "Assistant listed successfully"
  }
  ```

<br>

---------------------

- The physician can also update the assistant info such as `full_name`.
    > PUT: `clinic/<uuid:clinic_uuid>/assistant/<int:assistant_id>`
    
    **Request Body**
    ```json
    {
        "full_name": "Mohamed Ahmed"
    }
    ```
    
    **Response Body**
    ```json
    {
        "success": true,
        "data": {
            "id": 184,
            "full_name": "Newest Assistant",
            "clinic_name": "Clinic Name",
            "clinic_uuid": "f243ef97-542c-4603-b1d2-3d9a5b7d08c1",
            "national_id": "20202021233748",
            "mobile": "01005171551",
            "email": "Earline25@yahoo.com",
            "dentist_id": 53
        },
        "message": "Assistant updated successfully"
    }
    ```

<br>

---------------------

- The physician can also delete the assistant.
    > DELETE: `clinic/<uuid:clinic_uuid>/assistant/<int:assistant_id>`
    
    **Response Body**
    ```json
    {
        "success": true,
        "data": null,
        "message": "Assistant deleted successfully"
    }
    ```
    
<br>

----------------------