for logz.io:

```
wget https://raw.githubusercontent.com/logzio/public-certificates/master/COMODORSADomainValidationSecureServerCA.crt
kubectl create secret generic logzio --from-file=COMODORSADomainValidationSecureServerCA.crt
echo -n 'YOUR_LOGZIO_TOKEN_HERE' | base64 > token
kubectl create secret generic logzio --from-file=token
kubectl apply -f filebeat-kubernetes.yaml
```
