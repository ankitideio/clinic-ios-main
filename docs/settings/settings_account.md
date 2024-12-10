# Settings - Account

- Account info
  - E-Mail Address
  - Mobile No.
  - National ID
- Reset Password


<br>

---------------

## Account Info

- Account Info: `email`, `mobile`, `national_id`
- *UI fields*: Email Address, Mobile No., National ID

- To view Account Info
    > GET: `dentist/user`

    **Response Message**

    ```json
    {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "email": "body@gmail.com",
            "mobile": "01002212343",
            "national_id": "28805251234567"
        },
        "message": "Dentist Custom User Info retrieved successfully."
    }
    ```

- To update Account Info
  > PUT: `dentist/user`

  **Request Body**
  ```json
  {
      "email": "body@gmail.com",
      "mobile": "01002212343",
      "national_id": "28805251234567"
  }
  ```

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "email": "body@gmail.com",
            "mobile": "01002212343",
            "national_id": "28805251234567"
        },
        "message": "Dentist Custom User Information updated successfully."
    }
    ```

    <br>

----------------------

## Reset Password

- Physician can update his password, by entering: `old_password`, `new_password`, `confirm_new_password`.

> PUT: `change-password/`

**Request Body**
```json
{
    "old_password": "123456",
    "new_password": "test123"
}
```

**Response Message**
```json
{
    "success": true,
    "data": [],
    "message": "Password updated successfully"
}
```

<br>


----------------------

