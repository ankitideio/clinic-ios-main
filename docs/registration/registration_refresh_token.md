# Registration - Refresh Token

- In case the _token_ obtained from **Login** API has expired, `refresh` is used to obtain new `access` token.

  > POST: `token/refresh/`

  ```json
  {
    "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9 eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY3OTk0Nzg0OCwiaWF0IjoxNjc5ODYxNDQ4LCJqdGkiOiIzYTQxNjliNDY1Y2Y0ODk2OTE5NWFiNjhlZTVlZTM1ZiIsInVzZXJfaWQiOiIwZGM1NmVkMS0zMzE0LTQ0N2ItOWMyYi05MGM2ZmIxMWYxNTgifQ._O_auzHFR-Ff43KtKqVetKq4AWSZVhsz_dF4qzHh5NM"
  }
  ```

  <br>

----------------------