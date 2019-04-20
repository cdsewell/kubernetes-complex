docker build -t cdsewell/multi-client:latest -t cdsewell/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cdsewell/multi-server:latest -t cdsewell/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cdsewell/multi-worker:latest -t cdsewell/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cdsewell/multi-client:latest
docker push cdsewell/multi-server:latest
docker push cdsewell/multi-worker:latest

docker push cdsewell/multi-client:$SHA
docker push cdsewell/multi-server:$SHA
docker push cdsewell/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=cdsewell/multi-client:$SHA
kubectl set image deployments/server-deployment server=cdsewell/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cdsewell/multi-worker:$SHA