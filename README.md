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
khj helm-all
```

### Helm init

> Initialize as client only

```bash
khj helm-init
```

### Helm set version

> In your Chart.yaml you must version set as **{HELM_VERSION}**

```bash
DIRECTORY_CHART=helm-dir \
HELM_VERSION=0.1.0-alpha.1 \
khj helm-set-version
```

### Helm show Chart.yaml

```bash
DIRECTORY_CHART=helm-dir khj helm-show-chart
```

### Helm package

```bash
DIRECTORY_CHART=helm-dir khj helm-package
```

### Helm deploy

> Deploy to jfrog artifactory

```bash
DIRECTORY_CHART=helm-dir \
VERSION=0.1.0-alpha.1 \
REPO_USER=xxx \
REPO_PASS=xxx \
REPO_URL=xxx \
khj helm-deploy
```

## Usage in CircleCI 2.0

> Example for CircleCI with GitHub release

For this usage, you must set variables:

* **JFROG_HELM_REPO_LOCAL** = URL to your JFrog Helm repository (local)
* **JFROG_USER** = JFrog login
* **JFROG_PASS** = JFrog password

Structure project:

* **.helm/chart-name/** - Chart.yaml, etc. **chart-name** is same as name git repository **CIRCLE_PROJECT_REPONAME**

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
          command: |
            DIRECTORY_CHART=.helm/${CIRCLE_PROJECT_REPONAME} \
            VERSION=${CIRCLE_TAG:1} \
            REPO_URL=${JFROG_HELM_REPO_LOCAL} REPO_USER=${JFROG_USER} \
            REPO_PASS=${JFROG_PASS} \
            khj helm-all

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
