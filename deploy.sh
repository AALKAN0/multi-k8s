docker build -t ahmetalkan/multi-client:latest -t ahmetalkan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmetalkan/multi-server:latest -t ahmetalkan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmetalkan/multi-worker:latest -t ahmetalkan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ahmetalkan/multi-client:latest
docker push ahmetalkan/multi-server:latest
docker push ahmetalkan/multi-worker:latest
docker push ahmetalkan/multi-client:$SHA
docker push ahmetalkan/multi-server:$SHA
docker push ahmetalkan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmetalkan/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmetalkan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmetalkan/multi-worker:$SHA