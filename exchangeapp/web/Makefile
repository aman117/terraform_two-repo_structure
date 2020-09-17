repository = exchangeapp/web
version = latest
account = 401413892014
region =  us-east-1
namespace = exchangeapp
deployment= exchangeapp-web
replicas= 2

kubectl := kubectl -n $(namespace)
aws := aws --region $(region)

replacements="\
s|NAMESPACE|$(namespace)|g;\
s|ACCOUNT|$(account)|g;\
s|REGION|$(region)|g;\
s|REPLICAS|$(replicas)|g;\
s|DEPLOYMENT|$(deployment)|g;\
s|REPOSITORY|$(repository)|g;\
s|VERSION|$(version)|g\
"
############################################################################################




# Create a repository for Web Server
create-repo:
	@$(aws) ecr create-repository --repository-name $(repository)




# Delete the repository in ECR.
delete-repo:
	@$(aws) ecr delete-repository --repository-name $(repository)




# Login to AWS ECR for getting privilages
ecr-login:
	@$(aws) ecr get-login-password | docker login --username AWS --password-stdin $(account).dkr.ecr.$(region).amazonaws.com




# Build Web Server's image by using Dockerfile
build:
	@docker build -t $(account).dkr.ecr.$(region).amazonaws.com/$(repository):$(version) .





# Before pushing the images, you need to make sure you logged in.
# Push the image to AWS ECR
push: ecr-login
	@docker push $(account).dkr.ecr.$(region).amazonaws.com/$(repository):$(version)





# Create a namespace for the different team's app as a best practice
namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl apply -f -
delete-namespace:
	@cat namespace.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found





# Deploy the Web Server with its own service
web: namespace
	@cat web.yaml | sed $(replacements) | kubectl apply -f -
delete-web:
	@cat web.yaml | sed $(replacements) | kubectl delete -f - --ignore-not-found




# Scale your deployments as you want
scale: namespace web





# Rollback your deployment to previous version
rollback:
	@$(kubectl) rollout history deployment.v1.apps/$(deployment)
	@$(kubectl) rollout undo deployment.v1.apps/$(deployment) || (echo "There is no any previous version of $(deployment) deployment."; exit 1)




# Check the status of your environment
get:
	@$(kubectl) get all # --ignore-not-found
describe:
	@$(kubectl) describe pod $$($(kubectl) get pod \
		-l "tier=frontend" -o=jsonpath='{.items[0].metadata.name}')
logs:
	@$(kubectl) logs $$($(kubectl) get pod \
		-l "tier=frontend" -o=jsonpath='{.items[0].metadata.name}')




# Test the connection between our architecture.(WEB <=> API <=> DB)
test:
	@$(kubectl) exec -it $$($(kubectl) get pod \
		-l "tier=frontend" -o=jsonpath='{.items[0].metadata.name}') -- curl -i localhost:3000
forward:
	@$(kubectl) port-forward $$($(kubectl) get pod \
		-l "tier=frontend" -o jsonpath="{.items[0].metadata.name}")  3000:3000




# Delete all you created
# Keep it in mind, it will delete whole environment including the namespace.
delete-all: delete-web delete-namespace
