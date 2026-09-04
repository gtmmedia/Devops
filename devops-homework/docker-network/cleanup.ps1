$containers = @("homework-frontend", "homework-backend", "homework-db", "homework-apache", "homework-volume-nginx")
foreach ($container in $containers) { docker rm -f $container 2>$null | Out-Null }

$networks = @("homework-frontend-net", "homework-backend-net", "homework-db-net")
foreach ($network in $networks) { docker network rm $network 2>$null | Out-Null }

docker network rm homework-overlay-net 2>$null | Out-Null
docker swarm leave --force 2>$null | Out-Null

Write-Host "Docker homework containers and networks removed."