### Ambiente | Cluster Kubernetes (GKE)

#### Instalação ambiente

```bash
chmod +x instalacao.sh
./instalacao.sh
```

|Com o script acima, instale apenas as opções listadas abaixo::||
|  :--------- | :---------------- |
| `1-Nginx Controller` |`kubeclt get pod -n ingress-nginx`|
| `2-Cert Manager`|`kubeclt get pod -n cert-manager`|
| `3-App Giropops Senha`|`kubectl get pod`|
| `4-Redis`|`kubectl get pod`|

#### No arquivo "cluster-issuer.yaml" altere a chave e-mail para o seu e-mail. 
|Execute somente a opção 5 do script.||
|  :--------- | :---------------- |
| `5-Cluster Issuers` |`kubeclt get pod -n ingress-nginx`|
|||
#### Verifique se a autoridade certificado letsencrypt esta ativa no seu cluster.

```bash
kubectl get clusterissuers
```
```
NAME               READY   AGE
letsencrypt-prod   True    46m
```
#### Com o resultado true da autoridade certificadora, altere o arquivo ingress.yaml para incluir seu domínio. Observação: Não se esqueça de apontar o DNS para o IP do NGINX Controller.
|Execute somente a opção 6 do script.||
|  :--------- | :---------------- |
| `6-Ingress` |`kubeclt get ingress`|
|||
```
NAME    CLASS   HOSTS                     ADDRESS          PORTS     AGE
nginx   nginx   giropops.deltcom.com.br   107.178.213.49   80, 443   42m
```
#### Validando o certificado

```bash
kubectl get certificate
```
```
NAME               READY   SECRET             AGE
letsencrypt-prod   True    letsencrypt-prod   19m
```

#### Instale o Horizontal Pod Autoscaler (HPA) para o aplicativo giropops, configurando um mínimo de 3 réplicas e um máximo de 10.
|Execute somente a opção 7 do script.||
|  :--------- | :---------------- |
| `7-HPA` |`kubeclt get horizontalpodautoscalers`|
|||

```
NAME        REFERENCE                    TARGETS           MINPODS   MAXPODS   REPLICAS   AGE
nginx-hpa   Deployment/giropops-senhas   5%/50%, 95%/50%   3         10        10         39m
```
#### Instale a ferramenta para realizar testes de estresse no aplicativo e configurar o Horizontal Pod Autoscaler (HPA).
|Execute somente a opção 8 e, após concluir, execute a opção 9 do script..||
|  :--------- | :---------------- |
| `8-Locust Config Map` |`kubeclt get configmaps`|
| `9-Locust` |`kubeclt get pod`|
|||

#### Pegando o ip externo do Locust
```bash
kubectl get svc | awk '/locust-giropops/' | awk -F ' ' '{print $4}'
```
### Acessando o Locust via web
```http://<ip-externo-locust>```

### No site do Locust, insira as seguintes informações:
```bash
Number of user: 1000
Spawn rate: 20
Host: dns da sua aplicação
Clique em Start swarming
```

### Para acompanhar o escalonamento automático, execute o seguinte comando:

```bash
kubectl get pod -w
```
### Com o comando abaixo, no campo "Deployment pods:", você pode visualizar a quantidade de réplicas "current" e "desired":

```bash
kubectl describe horizontalpodautoscalers nginx-hpa
```
```
Deployment pods:              8 current / 10 desired
```