#!/bin/sh

noArg() {
    echo >&2 '
***********
** ERROR **
***********
'
    echo "ERROR: You must set one argument 'khj (helm-init, helm-set-version, helm-show-chart, helm-package, helm-deploy, helm-all)'" >&2
    exit 1
}

checkDirectoryChart() {
    if [ ! "${DIRECTORY_CHART:-}" ]; then
        echo "ERROR variable \$DIRECTORY_CHART is not set"
        exit 1
    fi
}

checkVersionExist() {
    if [ ! "${VERSION:-}" ]; then
        echo "ERROR variable \$VERSION is not set"
        exit 1
    fi
}

checkRepoUserExist() {
    if [ ! "${REPO_USER:-}" ]; then
        echo "ERROR variable \$REPO_USER is not set"
        exit 1
    fi
}

checkRepoPassExist() {
    if [ ! "${REPO_PASS:-}" ]; then
        echo "ERROR variable \$REPO_PASS is not set"
        exit 1
    fi
}

checkRepoUrlExist() {
    if [ ! "${REPO_URL:-}" ]; then
        echo "ERROR variable \$REPO_URL is not set"
        exit 1
    fi
}

helmInit() {
    echo "Helm init"
    helm init --client-only
}

helmSetVersion() {
    echo "Helm set version"
    checkDirectoryChart;
    checkVersionExist;
    sed -i -e "s/{HELM_VERSION}/${VERSION}/g" ${DIRECTORY_CHART}/Chart.yaml
}

helmShowChart() {
    echo "Helm show chart"
    checkDirectoryChart;
    cat ${DIRECTORY_CHART}/Chart.yaml
}

helmPackage() {
    echo "Helm package"
    checkDirectoryChart;
    helm package ${DIRECTORY_CHART}/ -d ${DIRECTORY_CHART}
}

helmDeploy() {
    echo "Helm deploy"
    checkDirectoryChart;
    checkVersionExist;
    checkRepoUserExist;
    checkRepoPassExist;
    checkRepoUrlExist;
    TGZ_FILENAME=$(basename $DIRECTORY_CHART)-${VERSION}.tgz
    curl -u ${REPO_USER}:${REPO_PASS} -T ${DIRECTORY_CHART}/${TGZ_FILENAME} "${REPO_URL}/${TGZ_FILENAME}"

}

case $1 in
    "")                 noArg;;
    "helm-init")        helmInit;;
    "helm-set-version") helmSetVersion;;
    "helm-show-chart")  helmShowChart;;
    "helm-package")     helmPackage;;
    "helm-deploy")      helmDeploy;;
    "helm-all")         helmInit;helmSetVersion;helmShowChart;helmPackage;helmDeploy;;
esac