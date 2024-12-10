# Settings - Physician

- Personal Info
  - Full Name En
  - Full Name Ar
  - Qualifications En
  - Qualifications Ar
  - City

<br>

------

- Personal Info: `full_name_en`, `full_name_ar`, `qualifications_en`, `qualifications_ar`, `city`.
- *UI fields*: Full Name EN, Full Name AR, Qualifications EN, Qualifications AR, City.

    - To view Personal Info
        > GET: `dentist/info`

        **Response Message**
        ```json
        {
                "success": true,
                "data": {
                    "id": 53,
                    "full_name_en": "Body Ahmed Ibrahim",
                    "full_name_ar": "بودي",
                    "qualifications_en": "doctor",
                    "qualifications_ar": "دكتور",
                    "city": "Cairo"
                },
                "message": "Dentist Information retrieved successfully."
        }
        ```

    - To update Personal Info
        > PUT: `dentist/info`
        
        **Request Body**
        ```json
        {
            "full_name_en": "Body Ahmed Ibrahim",
            "full_name_ar": "بودي",
            "qualifications_en": "doctor",
            "qualifications_ar": "دكتور",
            "city": "Cairo"
        }
        ```
        
        **Response Message**
        ```json
        {
            "success": true,
            "data": {
                "id": 53,
                "full_name_en": "Body Ahmed Ibrahim",
                "full_name_ar": "بودي",
                "qualifications_en": "doctor",
                "qualifications_ar": "دكتور",
                "city": "Cairo"
            },
            "message": "Dentist information updated successfully."
        }
        ```

    - `city` shall be a list of cities. The list can be obtained from the following endpoint.
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
