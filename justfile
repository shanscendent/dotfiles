repository := "ghcr.io/shanscendent/dotfiles"
image := "ubuntu"
base_commit := "43b50044a47cf185dc089127eaa8145e77ec08b4" # this commit is right before docker images are included
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

[working-directory: 'docker/suse15']
docker-suse:
  docker build --secret id=GITHUB_TOKEN -t {{repository}}/suse15:0.0.{{patch}} .
  docker image tag {{repository}}/suse15:0.0.{{patch}} {{repository}}/suse15:latest

push-docker-suse:
  docker push {{repository}}/suse15:0.0.{{patch}}
  docker push {{repository}}/suse15:latest
