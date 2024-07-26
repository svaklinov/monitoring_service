#commands

docker build -t monitoring-app .

docker run -p 5000:5000 monitoring-app

docker-compose up -d
