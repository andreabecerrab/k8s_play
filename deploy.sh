docker build -t andreabecerra/multi-client:latest -t andreabecerra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreabecerra/multi-server:latest -t andreabecerra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreabecerra/multi-worker:lastest -t andreabecerra/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push andreabecerra/multi-client:lastest
docker push andreabecerra/multi-server:latest
docker push andreabecerra/multi-worker:latest

docker push andreabecerra/multi-client:$SHA
docker push andreabecerra/multi-server:$SHA
docker push andreabecerra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andreabecerra/multi-server:$SHA
kubectl set image deployments/client-deployment client=andreabecerra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andreabecerra/multi-worker:$SHA
