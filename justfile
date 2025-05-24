repository := "ghcr.io/shanscendent/dotfiles"
image := "ubuntu"
base_commit := "ba0b13a5b803e2a479b5557f697865fe225b5d09" # this commit is right before docker images are included
patch := shell("git rev-list --count $1", base_commit + "..HEAD")

# show list of recipes
default:
  just --list

# build docker image
[working-directory: 'docker/Ubuntu']
docker:
  docker build --no-cache --pull -t {{repository}}/ubuntu:0.0.{{patch}} .
  docker image tag {{repository}}/ubuntu:0.0.{{patch}} {{repository}}/ubuntu:latest

# push image to GHCR
push-docker:
  docker push {{repository}}/ubuntu:0.0.{{patch}}
  docker push {{repository}}/ubuntu:latest

[working-directory: 'docker/Ubuntu-lite']
docker-lite:
  docker build --no-cache --secret id=GITHUB_TOKEN -t {{repository}}/ubuntu-lite:0.0.{{patch}} .
  docker image tag {{repository}}/ubuntu-lite:0.0.{{patch}} {{repository}}/ubuntu-lite:latest

push-docker-lite:
  docker push {{repository}}/ubuntu-lite:0.0.{{patch}}
  docker push {{repository}}/ubuntu-lite:latest
