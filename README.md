# Re:VIEW container for Docker

Re:VIEW container is Docker image to generate EPUB/PDF by Re:VIEW.

## Usage

```
$ docker pull mshibata/docker-review
$ mkdir ~/book
$ docker run --rm -v ~/book:/data mshibata/docker-review review-init vol1

Generate EPUB
$ docker run --rm -v ~/book/vol1:/data mshibata/docker-review rake epub

Generate PDF
$ docker run --rm -v ~/book/vol1:/data mshibata/docker-review rake pdf

Validate EPUB file
$ docker run --rm -v ~/book/vol1:/data review/pdf java -jar /opt/epubcheck/epubcheck.jar book.epub
```

## License

* MIT License
