FROM ocaml/opam:debian

RUN sudo apt-get install -y libgmp3-dev && \
    opam install jbuilder cohttp cohttp-lwt-unix tls

RUN mkdir app

COPY jbuild /home/opam/app
COPY example_server.ml /home/opam/app

WORKDIR /home/opam/app

RUN openssl req -x509 -newkey rsa:4096 -keyout server.key -out server.crt -days 3650 -nodes -subj "/C=UK/ST=foo/L=bar/O=baz/OU= Department/CN=example.com"
RUN bash -c "source ~/.profile && jbuilder build example_server.exe"

EXPOSE 4433

CMD ./_build/default/example_server.exe
