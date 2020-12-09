FROM ocaml/opam2:4.11
RUN cd /home/opam/opam-repository.
RUN git pull
WORKDIR /app
RUN sudo chown -R opam:nogroup .
RUN opam update
RUN opam upgrade
RUN opam install -y dune
RUN eval `opam config env`
RUN opam install -y lwt caqti caqti-lwt caqti-driver-postgresql ppx-rapper
COPY --chown=opam:nogroup . /app 
RUN rm main.exe || true
RUN opam config exec == dune build main.exe --profile=static
RUN gcc -shared -fPIC -ldl -o hook.so hook.c
RUN m _build/default/main.exe main.exe

