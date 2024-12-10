# Settings - Pricing

We shall consider multiple sections here i.e. UI:
- Private Patient
- Contracts i.e. multiple insurance companies

- For either of them, *UI fields* are fixed.
    - Examination
    - Follow Up
    - Consultation
    - Emergency
    - Others

- The main page appearing under the tab, will be a list containing -at least- Private Patients Pricing.

<br>

----------------------

## Private Patient

- At the beginning, physician must enter his pricing list for his private patients.
- This is where the physician enter his pricing fees: `examination`, `follow_up`, `consultation`, `emergency`, `others`.

  > POST: `dentist/pricing`
  
  **Request Body**
  ```json
  {
        "pricing": {
            "others": 0,
            "examination": 400,
            "follow_up": 200,
            "consultation": 800,
            "emergency": 100
        }
  }
  ```

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "pricing": {
                "others": 0,
                "examination": 400,
                "follow_up": 200,
                "consultation": 800,
                "emergency": 100
            }
        },
        "message": "Dentist pricing updated successfully"
  }
  ```

-----

- The physician can view his pricing fees.
  > GET: `dentist/pricing`
  
  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "id": 53,
            "full_name_en": "Body Ahmed Ibrahim",
            "pricing": {
                "others": 0,
                "emergency": 100,
                "follow_up": 200,
                "examination": 400,
                "consultation": 800
            }
        },
        "message": "Dentist Pricing Info retrieved successfully."
  }
  ```

<br>

----------------------

## Insurance Co.

- Physician will have the option to add those same fees, but for an insurance company of his choice.
- _Note_, the physician can add multiple insurance companies, but he can only add one pricing for each insurance company.

- The `insurance` field is a dropdown list of all insurance companies that can be retrieved from 
    > GET: `assets/insurance`.
- `insurance` field is an id of the insurance.

    > POST: `dentist/contract_pricing`

    **Request Body**
    ```json
    {
        "insurance": 3,
        "pricing": {
            "others": 0,
            "examination": 400,
            "follow_up": 200,
            "consultation": 800,
            "emergency": 100
        }
    }
    ```

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 2,
            "insurance": "Globemed",
            "pricing": {
                "others": 0,
                "examination": 400,
                "follow_up": 200,
                "consultation": 800,
                "emergency": 100
            }
        },
        "message": "Contract pricing added successfully."
    }
    ```
------

- Listing all different pricing categories e.g. AXA, Globemed, Engineering Synd.
    > GET: `dentist/contract_pricing`

    **Response Message**
    ```json
    {
        "success": true,
        "data": [
            {
                "id": 1,
                "insurance": "AXA",
                "pricing": {
                    "others": 0,
                    "examination": 400,
                    "follow_up": 200,
                    "consultation": 800,
                    "emergency": 100
                }
            },
            {
                "id": 2,
                "insurance": "Globemed",
                "pricing": {
                    "others": 0,
                    "examination": 400,
                    "follow_up": 200,
                    "consultation": 800,
                    "emergency": 100
                }
            }
        ],
        "message": "Contract pricing retrieved successfully."
    }
    ```


<br>

----------------------

- Getting each pricing category separately.
    > GET: `dentist/contract_pricing/<int:contract_id>`

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 1,
            "insurance": "Axa",
            "pricing": {
                "others": 0,
                "emergency": 100,
                "follow_up": 200,
                "examination": 500,
                "consultation": 800
            }
        },
        "message": "Dentist Contract Pricing Info retrieved successfully."
    }
    ```

------

- Updating each category separately
    > PUT: `dentist/contract_pricing/<int:contract_id>`

    **Request Body**
    ```json
    {
        "pricing": {
            "others": 0,
            "examination": 400,
            "follow_up": 200,
            "consultation": 800,
            "emergency": 100
        }
    }
    ```

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "id": 1,
            "insurance": "Axa",
            "pricing": {
                "others": 0,
                "examination": 400,
                "follow_up": 200,
                "consultation": 800,
                "emergency": 100
            }
        },
        "message": "Contract pricing updated successfully."
    }
    ```

-----

- Deleting a pricing category.
    > GET: `dentist/contract_pricing/<int:contract_id>`

    **Response Message**
    ```json
    {
        "success": true,
        "data": null,
        "message": "Contract pricing deleted successfully."
    }
    ```

<br>

----------------------
