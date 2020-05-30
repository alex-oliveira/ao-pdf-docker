# AO-PDF-DOCKER

Running container.
````
$ docker container run -p 8080:8080 ao-pdf
````

Accessing the test route in the browser.
````
http://localhost:8080/pdf/test
````

Services available at API:
````
GET/POST -> http://localhost:8080/pdf/fill
````
````
GET -> http://localhost:8080/pdf/download
````
