# Settings - Reach Us

- The physician can simply write down requests for updates or ask any questions. This is mainly for physician's communication with Lnkr, as a company. This shall be later a chat-like page.

-------

- *First View* is a list of all previous requests with an *Add New Request* button.
- Listing all previous requests: `title`, `created_date` i.e. DD.MM.YY @ HH:MM

  > GET: `dentist/<int:dentist_id>/request/`

  **Response Message**
  ```json
  {
        "success": true,
        "data": [
            {
                "uuid": "7ca74ef5-ade0-48ee-a028-d623086698ba",
                "dentist": "Body Ahmed Ibrahim",
                "title": "Lab22",
                "request": "",
                "comments": "",
                "done": false,
                "created_date": "2022-11-10T15:05:44.083347+02:00"
            },
            {
                "uuid": "0b2b4fb0-7cad-4354-8e51-3603d426a5d9",
                "dentist": "Body Ahmed Ibrahim",
                "title": "Title 1",
                "request": "",
                "comments": "",
                "done": false,
                "created_date": "2022-11-08T18:12:51.770775+02:00"
            },
            {
                "uuid": "3227961c-65c4-4a43-8610-a4a2dd585065",
                "dentist": "Body Ahmed Ibrahim",
                "title": "Lab22",
                "request": "",
                "comments": "",
                "done": false,
                "created_date": "2022-11-08T17:47:51.063304+02:00"
            },
            {
                "uuid": "e329770f-c621-4cb7-aadc-f4cfca7fb6c3",
                "dentist": "Body Ahmed Ibrahim",
                "title": "Lab22",
                "request": "",
                "comments": "",
                "done": false,
                "created_date": "2022-11-08T15:50:32.524590+02:00"
            },
            {
                "uuid": "6e6ef741-d6c9-4d73-b23e-ba437d9f1cd7",
                "dentist": "Body Ahmed Ibrahim",
                "title": "body request",
                "request": "reqes",
                "comments": "",
                "done": false,
                "created_date": "2022-10-18T12:35:42.689042+02:00"
            }
        ],
        "message": "Requests list retrieved successfully."
  }
  ```

-------

- Create a new request:
- A request: `title`, `request`, `comments`

  > POST: `dentist/<int:dentist_id>/request/`
  
  **Request Body**
  ```json
  {
        "title": "Request Title",
        "request": "Request Body",
        "comments": "comment"
  }
  ```

  **Response Message**
  ```json
  {
        "success": true,
        "data": {
            "uuid": "ebc13e34-7cb9-4a4f-9a5a-b557c58d3e9c",
            "dentist": "Body Ahmed Ibrahim",
            "title": "Request Title",
            "request": "Request Body",
            "comments": "comment",
            "done": false,
            "created_date": "2023-04-04T16:44:11.134113+02:00"
        },
        "message": "Request Created successfully."
  }
  ```

-------

-  Getting each request separately: `title`, `body`, `comments`, `created_date`
    > GET: `dentist/<int:dentist_id>/request/<uuid:request_uuid>`

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "uuid": "2e3a34df-94ee-4cb3-8980-c2f90722c2fd",
            "dentist": "Body Ahmed Ibrahim",
            "title": "New Title",
            "request": "new request",
            "comments": "comment",
            "done": false,
            "created_date": "2023-04-09T15:10:43.627327+02:00"
        },
        "message": "Request Retrived successfully."
    }
    ```

-------

- Updating a request
    > PUT: `dentist/<int:dentist_id>/request/<uuid:request_uuid>/`

    **Request Body**
    ```json
    {
        "title": "New Title",
        "request": "new request",
        "comments": "comment"
    }
    ```

    **Response Message**
    ```json
    {
        "success": true,
        "data": {
            "uuid": "2e3a34df-94ee-4cb3-8980-c2f90722c2fd",
            "dentist": "Body Ahmed Ibrahim",
            "title": "New Title",
            "request": "new request",
            "comments": "comment",
            "done": false,
            "created_date": "2023-04-09T15:10:43.627327+02:00"
        },
        "message": "Request Updated successfully."
    }
    ```
<br>


----------------------
