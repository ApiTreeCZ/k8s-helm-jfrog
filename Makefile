default: create-docker

# only for local testing
test-build:
	@echo "Test docker build"
	docker build -t apitreecz/k8s-helm-jfrog:latest .

# only for local testing
test-go:
	docker run -dit apitreecz/k8s-helm-jfrog:latest

docker-login:
	@echo "Login to docker remote repository"
	docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}

docker-build:
	@echo "Build docker image"
	docker build -t ${DOCKER_IMAGE}:latest .

docker-tag:
	@echo "Add docker tag"
	docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:${DOCKER_VERSION}

docker-push:
	@echo "Push to docker repository"
	docker push ${DOCKER_IMAGE}
