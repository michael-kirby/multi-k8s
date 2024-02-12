docker build -t mkirby1974/multi-client:latest -t mkirby1974/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mkirby1974/multi-server:latest -t mkirby1974/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mkirby1974/multi-worker:latest -t mkirby1974/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mkirby1974/multi-client:latest
docker push mkirby1974/multi-client:$SHA
docker push mkirby1974/multi-server:latest
docker push mkirby1974/multi-server:$SHA
docker push mkirby1974/multi-worker:latest
docker push mkirby1974/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mkirby1974/multi-server:$SHA
kubectl set image deployments/client-deployment client=mkirby1974/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mkirby1974/multi-worker:$SHA
