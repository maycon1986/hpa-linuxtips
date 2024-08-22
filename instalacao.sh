#!/bin/bash
#Cria um case com 2 opções em shell script
echo "Selecione uma opção:"
echo "1 - Instalação do Nginx Controller"
echo "2 - Instalação Cert Manager"
echo "3 - Instalando o App Giropops Senha"
echo "4 - Instalando Redis"
echo "5 - Instalação do ClusterIssuer"
echo "6 - Instalação do Ingress"
echo "7 - Instalando HPA"
echo "8 - Instalando Config Map do Locust"
echo "9 - Instalando do Locust"

read opcao

case $opcao in
  1)
    echo "Instalando Nginx Controller..."
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
    ;;
  2)
    echo "Instalando Cert Manager..."
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.yaml
    ;;
  3)
    echo "Instalando App Giropops Senha..."
    kubectl apply -f app-giropops-senha.yaml
    ;;
  4)
    echo "Instalando Redis..."
    kubectl apply -f redis.yaml
    ;;
  5)
    echo "Instalando ClusterIssuer..."
    kubectl apply -f cluster-issuer.yaml
    ;;
  6)
    echo "Instalando Ingress..."
    kubectl apply -f ingress.yaml
    ;;
  7)
    echo "Instalando HPA..."
    kubectl apply -f hpa.yaml
    ;;
  8)
    echo "Instalando Config Map Locust..."
    kubectl apply -f locust-cm.yaml
    ;;
  9)
    echo "Instalando Locust..."
    kubectl apply -f locust.yaml
    ;;        
  *)
    echo "Opção inválida!"
    ;;
esac
