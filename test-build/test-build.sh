#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.0.201:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.0.201:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 4C2184EAA5287B4E2ADB --secret-key 5goidz54c49xJbGQRaCzSzn9VXqDtc8ohSsUFdyL -p python-redis-demo-build${BUILD_NUMBER} up -d

