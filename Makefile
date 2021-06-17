haproxy:
	helm install --atomic --values ./values_haproxy.yaml --set global.vector.image.repository=timberio/vector --set global.vector.image.tag=nightly-alpine vector ../vector/distribution/helm/vector

haproxy-agg:
	helm install --atomic --values ./values_haproxyagg.yaml --set global.vector.image.repository=timberio/vector --set global.vector.image.tag=nightly-alpine vector ../vector/distribution/helm/vector-aggregator

counter:
	kubectl apply -f ./counting-deploy.yaml

checker:
	kubectl apply -f ./checker-service.yaml
	kubectl apply -f ./checker.yaml

all: checker counter haproxy
	 
clean:
	helm uninstall vector
	kubectl delete -f ./counting-deploy.yaml
	kubectl delete -f ./checker-service.yaml
	kubectl delete -f ./checker.yaml
