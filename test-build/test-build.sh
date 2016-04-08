#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.5.47:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.5.47:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 21AE5E8252F12581FF10 --secret-key XMJoubynia2yP8f2sdEkg4EY74m4EHURQLSRYXsm -p python-redis-demo-build${BUILD_NUMBER} up -d

