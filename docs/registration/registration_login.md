# Registration - Login

- The physician shall be able to login using his `email`, `password`.
- API returns `access` and `refresh` which will be used in other APIs.

  > POST: `token/`

  ```json
  {
    "email": "body@gmail.com",
    "password": "123456"
  }
  ```

  <br>

----------------------