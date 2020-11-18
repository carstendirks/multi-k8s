docker built -t carstendirks/multi-client:latest -t carstendirks/multi-client:$SHA -f ./client/Dockerfile ./client
docker built -t carstendirks/multi-server:latest -t carstendirks/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t carstendirks/multi-worker:latest -t carstendirks/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push carstendirks/multi-client:latest
docker push carstendirks/multi-server:latest
docker push carstendirks/multi-worker:latest

docker push carstendirks/multi-client:$SHA
docker push carstendirks/multi-server:$SHA
docker push carstendirks/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=carstendirks/multi-server:$SHA
kubectl set image deployments/client-deployment server=carstendirks/multi-client:$SHA
kubectl set image deployments/worker-deployment server=carstendirks/multi-worker:$SHA