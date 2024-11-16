# create the certificate in TLS/SSL

* after route 53 configuration create nk card crt/key
```sh
    sudo snap install --classic certbot
    certbot certonly --manual --preferred-challenges=dns --key-type rsa --email mavrick202@gmail.com \
    --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.dhille.shop 


# after route 53 configuration create wild card crt/key

    certbot certonly --manual --preferred-challenges=dns --key-type rsa --email mavrick202@gmail.com \
    --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d dhille.shop

#  checking the route 53 



```
 
create the ingress controller 

` kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/aws/deploy.yaml`