docker rm -f ab-gateway-dashboard

#run kong-dashboard
docker run -d --name ab-gateway-dashboard -p 8080:8080 pgbi/kong-dashboard:v2
