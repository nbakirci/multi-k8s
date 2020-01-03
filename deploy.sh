docker build -t naregb/multi-client:latest -t naregb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naregb/multi-server:latest -t naregb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naregb/multi-worker:latest -t naregb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naregb/multi-client:latest
docker push naregb/multi-server:latest
docker push naregb/multi-worker:latest

docker push naregb/multi-client:latest:$SHA
docker push naregb/multi-server:latest:$SHA
docker push naregb/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naregb/multi-server:$SHA
kubectl set image deployments/client-deployment client=naregb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naregb/multi-worker:$SHA
