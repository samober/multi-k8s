docker build -t samober/multi-docker-client:latest -t samober/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t samober/multi-docker-server:latest -t samober/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t samober/multi-docker-worker:latest -t samober/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samober/multi-docker-client:latest
docker push samober/multi-docker-server:latest
docker push samober/multi-docker-worker:latest

docker push samober/multi-docker-client:$SHA
docker push samober/multi-docker-server:$SHA
docker push samober/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=samober/multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=samober/multi-docker-server:$SHA
kubectl set image deployments/worker-deployment worker=samober/multi-docker-worker:$SHA
