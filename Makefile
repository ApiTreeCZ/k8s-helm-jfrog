default: create-docker

# only for local testing
test-build:
	@echo "Test docker build"
	docker build -t apitree-docker-local.jfrog.io/k8s-helm-jfrog:latest .

# only for local testing
test-go:
	docker run -dit apitree-docker-local.jfrog.io/k8s-helm-jfrog:latest

docker-login:
	@echo "Login to docker remote repository"
	docker login -u ${DOCKER_USER} -p ${DOCKER_PASS} ${DOCKER_URL}

docker-build:
	@echo "Build docker image"
	docker build -t ${DOCKER_IMAGE}:${DOCKER_VERSION} .

docker-push:
	@echo "Push to docker repository"
	docker push ${DOCKER_IMAGE}
