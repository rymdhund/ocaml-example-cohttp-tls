# Ocaml web server

Simple example of serving https using cohttp in ocaml.

## Build and run in docker

```
docker build -t example-server .
docker run -it --rm -p 443:4433 example-server
```

# Run

Generate a self signed certificate:

```
openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 3650 -nodes
```

Install dependencies:

```
opam install jbuilder cohttp cohttp-lwt-unix tls
```

Build:

```
jbuilder build example_server.exe
```
