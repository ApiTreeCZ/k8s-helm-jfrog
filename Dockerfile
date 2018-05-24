FROM alpine:latest

LABEL maintainer="Ales Dostal <a.dostal@apitree.cz>"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./src /usr/src/app

ENV HELM_VERSION="v2.9.0"

ENV HELM_URL="https://storage.googleapis.com/kubernetes-helm"
ENV HELM_TARBALL="helm-${HELM_VERSION}-linux-amd64.tar.gz"
ENV STABLE_REPO_URL="https://kubernetes-charts.storage.googleapis.com/"
ENV INCUBATOR_REPO_URL="https://kubernetes-charts-incubator.storage.googleapis.com/"

RUN apk add --update ca-certificates \
    && apk add --update -t deps wget \
    && apk add --update make \
    && wget -q ${HELM_URL}/${HELM_TARBALL} \
    && tar xzfv ${HELM_TARBALL} \
    && mv ./linux-amd64/helm /usr/local/bin \
    && apk del --purge deps \
    && rm /var/cache/apk/* \
    && rm -f ${HELM_TARBALL}
