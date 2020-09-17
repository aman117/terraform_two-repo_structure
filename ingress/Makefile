controllerpod = $$(kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller -o jsonpath='{.items[0].metadata.name}')
namespace = exchangeapp
region = us-east-1
resourcename = ingress-exchange-web
servicename = web-service
serviceport = 80
email = info@312.school
domain = exchangeweb.net
subdomain = app
tlspath = /etc/letsencrypt/live/$(domain)-0001
tlssecret = tls-secret-ingress
certpem = $(shell cat $(tlspath)/cert.pem | base64 -w 0)
chainpem = $(shell cat $(tlspath)/chain.pem | base64 -w 0)
fullchainpem = $(shell cat $(tlspath)/fullchain.pem | base64 -w 0)
privkeypem = $(shell cat $(tlspath)/privkey.pem | base64 -w 0)
awscert = $(shell $(aws) secretsmanager get-secret-value --secret-id $(tlssecret) --version-stage AWSCURRENT --query 'SecretString' --output text | jq -r '."tls.crt"')
awskey = $(shell $(aws) secretsmanager get-secret-value --secret-id $(tlssecret) --version-stage AWSCURRENT --query 'SecretString' --output text | jq -r '."tls.key"')

aws := aws --region $(region)

replacements="\
s|NAMESPACE|$(namespace)|g;\
s|RESOURCE|$(resourcename)|g;\
s|SERVICENAME|$(servicename)|g;\
s|SERVICEPORT|$(serviceport)|g;\
s|EMAIL|$(email)|g;\
s|DOMAIN|$(domain)|g;\
s|SUB|$(subdomain)|g;\
s|TLSSECRET|$(tlssecret)|g;\
s|CERTPEM|$(certpem)|g;\
s|CHAINPEM|$(chainpem)|g;\
s|FULLCHAINPEM|$(fullchainpem)|g;\
s|PRIVKEYPEM|$(privkeypem)|g;\
s|AWSCERT|$(awscert)|g;\
s|AWSKEY|$(awskey)|g\
"




# Create/Delete the ingress-controller
ingress-up:
	@kubectl apply -f ingress-nginx.yaml
ingress-down:
	@kubectl delete -f ingress-nginx.yaml

# Check the current version of ingress-controller
version:
	@kubectl exec -n ingress-nginx -it $(controllerpod) -- /nginx-ingress-controller --version


namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl apply -f -


# Create/Renew your SSL certificates and upload them to AWS Secrets Manager
certbot:
ifeq ("$(wildcard $(tlspath))","")
	@certbot certonly \
		--manual \
		--preferred-challenges=dns \
		--email $(email) \
		--server https://acme-v02.api.letsencrypt.org/directory \
		--agree-tos \
		--manual-public-ip-logging-ok \
		--domain '*.$(domain)' \
		--domain $(domain)
else
	@certbot renew -q
endif
	@-$(aws) secretsmanager create-secret --name $(tlssecret)
	@$(aws) secretsmanager put-secret-value --secret-id $(tlssecret) --secret-string '{ "tls.crt":"$(fullchainpem)","tls.key":"$(privkeypem)" }'
	@make resource




tlssecret: namespace
	@cat tls-secret.yaml | sed $(replacements) | kubectl apply -f -


update-tls: namespace delete-resource tlssecret resource



# Ingress resources setup
resource: namespace tlssecret
	@cat ingress-resources.yaml | sed $(replacements) | kubectl apply -f -
delete-resource:
	@cat ingress-resources.yaml | sed $(replacements) | kubectl delete -f -
