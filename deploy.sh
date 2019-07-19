docker build -t awakenedmind/multi-client:latest -t awakenedmind/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t awakenedmind/multi-server:latest -t awakenedmind/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t awakenedmind/multi-worker:latest -t awakenedmind/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push awakenedmind/multi-client:latest
docker push awakenedmind/multi-server:latest
docker push awakenedmind/multi-worker:latest

docker push awakenedmind/multi-client:$SHA
docker push awakenedmind/multi-server:$SHA
docker push awakenedmind/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=awakenedmind/multi-server:$SHA
kubectl set image deployments/client-deployment client=awakenedmind/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=awakenedmind/multi-worker:$SHA