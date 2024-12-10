# Registration - Sign Up

- The physician can easily register for our Clinic App using his `mobile`, `email`, `password`, `national_id`, `full_name_en`, `full_name_ar`, `city`.
- It will create a Clinic named "Dr `full_name_en` Clinic" which will be located in `city `and assign the physician to it. 
- _Notice_, `city` shall be a list of cities, and the physician can choose from it.
- This list can be obtianed from the following endpoint: `assets/city`.

  > POST: `dentist/signup`

  ```json
  {
    "user_data": {
      "mobile": "01009072549",
      "email": "test_doctor1@lnkr.com",
      "password": "Test_1234",
      "national_id": "28501034341349"
    },
    "dentist": {
      "full_name_en": "Doctor Test",
      "full_name_ar": "محمد محمود",
      "city": "Cairo"
    }
  }
  ```

<br>

----------------------