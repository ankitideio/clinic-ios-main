# Registration - Forget Password

- In case of lost/forgotten password, physician shall be able to reset his password.

- *First Step*: The physician shall be able to request a reset email using his registered `email`.

  > POST: `request-reset-email/`

  ```json
  {
    "email": "body@gmail.com"
  }
  ```

-----

- *Second Step*: The physician shall use the link sent to his email which includes `token` and `user_uuid` to reset his password.
    
  > GET: `password-reset/`

-----

- *Third Step*: The physician shall be able to reset his password using `password`, `token`, `user_uuid`.

  > PATCH: `password-reset-complete/`

  ```json
  {
    "password": "Lnkr1234",
    "token": "beip9u-e678af7749ae20401332b2dec74b1ba3",
    "user_uuid": "ODI2OTU5YjUtYTA0MC00YzFhLTgxZGYtMWE5NmNiZWJhZWM1"
  }
  ```

<br>

----------------------
