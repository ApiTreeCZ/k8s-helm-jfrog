# k8s-helm-jfrog

> Docker image for creating helm package to jfrog

## Usage

### Helm all

> Run all task (_helm-init_, _helm-set-version_, _helm-show-chart_, _helm-package_, _helm-deploy_)

```bash
DIRECTORY_CHART=helm-dir \
VERSION=0.1.0-alpha.1 \
REPO_USER=xxx \
REPO_PASS=xxx \
REPO_URL=xxx \
make helm-all
```

### Helm init

> Initialize as client only

```bash
make helm-init
```

### Helm set version

> In your Chart.yaml you must version set as **{HELM_VERSION}**

```bash
DIRECTORY_CHART=helm-dir \
HELM_VERSION=0.1.0-alpha.1 \
make helm-set-version
```

### Helm show Chart.yaml

```bash
DIRECTORY_CHART=helm-dir make helm-show-chart
```

### Helm package

```bash
DIRECTORY_CHART=helm-dir make helm-package
```

### Helm deploy

> Deploy to jfrog artifactory

```bash
DIRECTORY_CHART=helm-dir \
VERSION=0.1.0-alpha.1 \
REPO_USER=xxx \
REPO_PASS=xxx \
REPO_URL=xxx \
make helm-deploy
```

## Usage in CircleCI 2.0

> Example for CircleCI with GitHub release

```yaml
version: 2
jobs:
  deploy_helm_chart:
    docker:
      - image: apitreecz/k8s-helm-jfrog:latest
    working_directory: ~/helm
    steps:
      - checkout
      - run:
          name: Package and deploy
          command: make helm-all
          environment:
            DIRECTORY_CHART=.helm/${CIRCLE_PROJECT_REPONAME}
            VERSION=${CIRCLE_TAG:1}
            REPO_URL=${JFROG_HELM_REPO_LOCAL}
            REPO_USER=${JFROG_USER}
            REPO_PASS=${JFROG_PASS}

workflows:
  version: 2
  build:
    jobs:
      - deploy_helm_chart:
          context: your-context
          filters:
            tags:
              only: /v[0-9]+(\.[0-9]+)*(-.+)?/
            branches:
              ignore: /.*/
```
