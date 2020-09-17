name =  k8s-cluster
namespace = metrics

kubectl := kubectl -n $(namespace)

replacements="\
s|NAMESPACE|$(namespace)|g;\
s|RELEASE-NAME|$(name)|g;\
"
############################################################################################


# Create namespace for Prometheus
namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl apply -f -

# Delete namespace for Prometheus
delete-namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl delete -f -



# Creating resources for Prometheus
run: namespace
	@cat manifests/prometheus/charts/kube-state-metrics/templates/clusterrole.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/clusterrolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/deployment.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/service.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/configmaps/alertmanager.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/configmaps/server.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/daemonsets/node-exporter.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/deployments/alertmanager.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/deployments/pushgateway.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/deployments/server.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/persistentvolumeclaims/alertmanager.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/persistentvolumeclaims/server.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-clusterrole.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-clusterrolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/node-exporter-serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-clusterrole.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-clusterrolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/server-clusterrole.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/server-clusterrolebinding.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/rbac/server-serviceaccount.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/services/alertmanager.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/services/node-exporter.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/services/pushgateway.yaml | sed $(replacements) | kubectl apply -f -
	@cat manifests/prometheus/templates/services/server.yaml | sed $(replacements) | kubectl apply -f -


stop:
	@cat manifests/prometheus/charts/kube-state-metrics/templates/deployment.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/service.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/daemonsets/node-exporter.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/services/node-exporter.yaml | kubectl delete -f -
	@cat manifests/prometheus/templates/deployments/alertmanager.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/services/alertmanager.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/deployments/server.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/services/server.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/deployments/pushgateway.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/services/pushgateway.yaml | sed $(replacements) | kubectl delete -f -



destroy: stop
	@cat manifests/prometheus/charts/kube-state-metrics/templates/clusterrole.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/clusterrolebinding.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/charts/kube-state-metrics/templates/serviceaccount.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/configmaps/alertmanager.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/configmaps/server.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/persistentvolumeclaims/alertmanager.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/persistentvolumeclaims/server.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-clusterrole.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-clusterrolebinding.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/alertmanager-serviceaccount.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/node-exporter-serviceaccount.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-clusterrole.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-clusterrolebinding.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/pushgateway-serviceaccount.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/server-clusterrole.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/server-clusterrolebinding.yaml | sed $(replacements) | kubectl delete -f -
	@cat manifests/prometheus/templates/rbac/server-serviceaccount.yaml | sed $(replacements) | kubectl delete -f -




# Test the prometheus 
forward:
	@$(kubectl) port-forward $$($(kubectl) get pod \
		-l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")  9090
