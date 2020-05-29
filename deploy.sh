docker build -t zarghamk/multi-client:latest -t zarghamk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zarghamk/multi-server:latest -t zarghamk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zarghamk/multi-worker:latest -t zarghamk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zarghamk/multi-client:latest
docker push zarghamk/multi-server:latest
docker push zarghamk/multi-worker:latest

docker push zarghamk/multi-client:$SHA
docker push zarghamk/multi-server:$SHA
docker push zarghamk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zarghamk/multi-server:$SHA
kubectl set image deployments/client-deployment client=zarghamk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zarghamk/multi-worker:$SHA
