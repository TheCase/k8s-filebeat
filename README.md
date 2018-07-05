for logz.io:

```
wget https://raw.githubusercontent.com/logzio/public-certificates/master/COMODORSADomainValidationSecureServerCA.crt
echo -n 'YOUR_LOGZIO_TOKEN_HERE' | base64 > token
kubectl create secret generic logzio --from-file=token --from-file=COMODORSADomainValidationSecureServerCA.crt -n kube-system
kubectl apply -f filebeat-kubernetes.yaml
```
