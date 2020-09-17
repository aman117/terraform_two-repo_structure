name =  k8s-cluster
namespace = metrics

kubectl := kubectl -n $(namespace)
awssecretname= grafana-secret
tlssecret = tls-secret-ingress
encrypted-passw = $(shell aws secretsmanager get-secret-value --secret-id $(awssecretname) --version-stage AWSCURRENT --query 'SecretString' --output text | jq -r '.password')
encrypted = $(shell echo -n "$(encrypted-passw)" | base64 -w 0)
awscert = $(shell aws secretsmanager get-secret-value --secret-id $(tlssecret) --version-stage AWSCURRENT --query 'SecretString' --output text | jq -r '."tls.crt"')
awskey = $(shell aws secretsmanager get-secret-value --secret-id $(tlssecret) --version-stage AWSCURRENT --query 'SecretString' --output text | jq -r '."tls.key"')

replacements="\
s|NAMESPACE|$(namespace)|g;\
s|RELEASE-NAME|$(name)|g;\
s|GRAFANA-PASSW|$(encrypted)|g;\
s|AWSCERT|$(awscert)|g;\
s|AWSKEY|$(awskey)|g\
"
############################################################################################


# Create namespace for Grafana
namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl apply -f -

# Delete namespace for Grafana
delete-namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl delete -f -



# Creating resources for Grafana
run:
	@cat manifests/grafana/templates/clusterrole.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/clusterrolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/configmap.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/deployment.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/grafana-ingress.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/podsecuritypolicy.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/role.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/rolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/secret.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/service.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/grafana/templates/tls-secret.yaml | sed $(replacements) | kubectl apply -f -


stop:
	@cat manifests/grafana/templates/deployment.yaml  | sed $(replacements) | kubectl delete -f - --ignore-not-found


destroy: stop
	@cat manifests/grafana/templates/clusterrole.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/clusterrolebinding.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/configmap.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/podsecuritypolicy.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/role.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/rolebinding.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/secret.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/service.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/serviceaccount.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/grafana-ingress.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found
	@cat manifests/grafana/templates/tls-secret.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found



# Port-forward to get to the Grafana dashboard
forward:
	@$(kubectl) port-forward $$($(kubectl) get pod \
		-l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}")  3000