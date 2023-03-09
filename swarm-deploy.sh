# check things like image tags, mounts, environment variables for your deployment

docker swarm init
docker network create --driver overlay --attachable=true argovis-db
docker volume create mongoback
docker service create --network argovis-db --name database --limit-memory 24GB --mount type=volume,source=mongoback,destination=/data/db  mongo:5.0.9
sleep 10
docker service create --network argovis-db --name redis --limit-memory 100MB argovis/redis:7.0.3-220713
sleep 5
docker container run --network argovis-db --name api -p 8080:8080 -e ARGOCORE='here' -e ARGONODE='core' -d --restart always argovis/api:2.6.1
docker container run --network argovis-db --name keymanager -p 3030:3030 -d --restart always -e SENDGRID_API_KEY=your_key_here argovis/api-keymanager:2.0.0
docker container run -d -p 3000:3000 --restart always argovis/react:2.2.3