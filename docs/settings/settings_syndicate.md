# Settings - Syndicate

- Syndicate Info: `syndicate_branch`, `syndicate_id`, `syndicate_registration_date`, `practitioner_license_no`, `practitioner_license_date`.
- `syndicate_branch` is a dropdown list of all syndicate branches that can be retrieved from
    > GET: `assets/syndicate_branch`.

- To view Syndicate Info
    > GET: `physician/syndicate`

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "syndicate_id": "12345",
            "syndicate_branch": "Cairo - Head Office",
            "syndicate_registration_date": "2001-06-02",
            "practitioner_license_no": "5464654",
            "practitioner_license_date": "2001-06-02"
        },
        "message": "Dentist Syndicate Info retrieved successfully."
    }
    ```

-------

- To add Syndicate Info
    > POST: `physician/syndicate`

    **Request Body**
    ```json
    {
        "syndicate_id": "12345",
        "syndicate_branch": "Cairo - Head Office",
        "syndicate_registration_date": "2001-06-02",
        "practitioner_license_no": "5464654",
        "practitioner_license_date": "2001-06-02"
    }
    ```
    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "syndicate_id": "12345",
            "syndicate_branch": "Cairo - Head Office",
            "syndicate_registration_date": "2001-06-02",
            "practitioner_license_no": "5464654",
            "practitioner_license_date": "2001-06-02"
        },
        "message": "Dentist information updated successfully."
    }
    ```


<br>

----------------------