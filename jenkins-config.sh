app_tag=`git ls-remote https://github.com/Sunilgit85/node-app HEAD | awk '{print $1}'`

docker_app="sunildockerr/nodejenkins:$app_tag"
docker build -t $docker_app .

docker login -u sunildockerr -p Linus@006 

docker push $docker_app

scp -i /var/lib/jenkins/dev.pem deploy.sh ec2-user@172.31.43.90:/tmp

ssh -i /var/lib/jenkins/dev.pem ec2-user@172.31.43.90 chmod +x /tmp/deploy.sh

ssh -i /var/lib/jenkins/dev.pem ec2-user@172.31.43.90 /tmp/deploy.sh $docker_app
