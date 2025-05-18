repository := "ghcr.io/shanscendent/dotfiles"
image := "ubuntu"
base_commit := "ba0b13a5b803e2a479b5557f697865fe225b5d09" # this commit is right before docker images are included
patch := shell("git rev-list --count $1", base_commit + "..HEAD")
tag := repository / image

# show list of recipes
default:
  just --list

# build and push docker image to GHCR, run this on every update to Linux configs
[working-directory: 'docker']
docker:
  docker build --no-cache --pull -t {{tag}}:0.0.{{patch}} .
  docker image tag {{tag}}:0.0.{{patch}} {{tag}}:latest
  docker push {{tag}}:0.0.{{patch}}
  docker push {{tag}}:latest
