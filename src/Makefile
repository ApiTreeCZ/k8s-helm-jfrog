default: helm-init

helm-init:
	@echo "Initializing helm (client only)"
	helm init --client-only

helm-set-version:
	@echo "Set Helm version to Chart.yaml"
	sed -i -e 's/{HELM_VERSION}/${VERSION}/g' ${DIRECTORY_CHART}/Chart.yaml

helm-show-chart:
	@echo "Show Chart.yaml"
	cat ${DIRECTORY_CHART}/Chart.yaml

helm-package:
	@echo "Create Helm package"
	helm package ${DIRECTORY_CHART}/ -d ${DIRECTORY_CHART}

helm-deploy:
	@echo "Deploy Helm Chart"
	$(eval TGZ_FILENAME=${DIRECTORY_CHART}-${VERSION}.tgz)
    curl -u ${REPO_USER}:${REPO_PASS} -T ${DIRECTORY_CHART}/${TGZ_FILENAME} "${REPO_URL}/${TGZ_FILENAME}"

helm-all:
	$(MAKE) helm-init
	$(MAKE) helm-set-version
	$(MAKE) helm-show-chart
	$(MAKE) helm-package
	$(MAKE) helm-deploy
