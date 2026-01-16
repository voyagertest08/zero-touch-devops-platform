#!/bin/bash
sed -i "s|IMAGE_URI|$IMAGE_URI|g" k8s/deployment.yaml
sed -i "s|APP_NAME|$APP_NAME|g" k8s/ingress.yaml
sed -i "s|DOMAIN_NAME|$DOMAIN_NAME|g" k8s/ingress.yaml
