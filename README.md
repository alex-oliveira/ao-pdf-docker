# AO-PDF (DOCKER)


## Run and Test

Running container.
````
$ docker container run -d -p 8080:8080 aocode/ao-pdf:1.0.0
````

Accessing the test route in the browser.
````
http://localhost:8080/pdf/test
````


## Available Services

#### GET / POST
````
http://localhost:8080/pdf/fill
````

#### GET
````
http://localhost:8080/pdf/download
````


## Collaboration

Collaborate with this image.

* https://github.com/alex-oliveira/ao-pdf-docker

Collaborate with this package.

* https://github.com/alex-oliveira/ao-pdf