FROM nixos/nix

# enable the flakes feature
RUN echo "experimental-features = flakes nix-command" > /etc/nix/nix.conf

COPY app.py flake.nix flake.lock /project/
WORKDIR project

# build all deps
RUN nix build .#run -o ./run && nix-collect-garbage

env PORT=5000
