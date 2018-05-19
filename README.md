# Re:VIEW container for Docker

Re:VIEW container is Docker image to generate EPUB/PDF by [Re:VIEW](http://reviewml.org/).

## Usage

Install Docker image from [DockerHub](https://hub.docker.com/r/mshibata/docker-review/).

```
$ docker pull mshibata/docker-review
```

Create Re:VIEW template.

```
$ mkdir ~/book
$ docker run --rm -v ~/book:/data mshibata/docker-review review-init vol1
```

Generate EPUB file.

```
$ docker run --rm -v ~/book/vol1:/data mshibata/docker-review rake epub
```

Generate PDF file.
```
$ docker run --rm -v ~/book/vol1:/data mshibata/docker-review rake pdf
```

Validate EPUB file.

```
$ docker run --rm -v ~/book/vol1:/data review/pdf java -jar /opt/epubcheck/epubcheck.jar book.epub
```

## License

* MIT License
