$ErrorActionPreference = "Stop"

function Remove-HomeworkContainer($name) {
    docker rm -f $name 2>$null | Out-Null
}

function Ensure-Network($name) {
    $existing = docker network ls --filter "name=^${name}$" --format "{{.Name}}"
    if (-not $existing) { docker network create $name | Out-Null }
}

function Wait-ForContent($url, $text) {
    for ($attempt = 0; $attempt -lt 20; $attempt++) {
        $content = curl.exe -s $url
        if ($content -match [regex]::Escape($text)) { return $true }
        Start-Sleep -Milliseconds 500
    }
    return $false
}

Remove-HomeworkContainer "homework-frontend"
Remove-HomeworkContainer "homework-backend"
Remove-HomeworkContainer "homework-db"
Remove-HomeworkContainer "homework-apache"
Remove-HomeworkContainer "homework-volume-nginx"

Ensure-Network "homework-frontend-net"
Ensure-Network "homework-backend-net"
Ensure-Network "homework-db-net"

docker pull nginx:alpine
docker pull alpine:3.20
docker pull mysql:8.4

docker run -d --name homework-frontend --network homework-frontend-net nginx:alpine | Out-Null
docker run -d --name homework-backend --network homework-frontend-net alpine:3.20 sleep 3600 | Out-Null
docker network connect homework-backend-net homework-backend
docker run -d --name homework-db --network homework-backend-net -e MYSQL_ROOT_PASSWORD=homework-password mysql:8.4 | Out-Null
docker network connect homework-db-net homework-db

Write-Host "Task 1 network memberships:"
docker network inspect homework-frontend-net --format "frontend-net: {{range .Containers}}{{.Name}} {{end}}"
docker network inspect homework-backend-net --format "backend-net: {{range .Containers}}{{.Name}} {{end}}"
docker network inspect homework-db-net --format "db-net: {{range .Containers}}{{.Name}} {{end}}"

docker exec homework-backend getent hosts homework-frontend | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Backend could not resolve frontend" }
docker exec homework-backend getent hosts homework-db | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Backend could not resolve database" }
docker exec homework-db getent hosts homework-backend | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Database could not resolve backend" }
Write-Host "PASS: backend resolves frontend and database; database resolves backend."

docker pull httpd:2.4-alpine
docker run -d --name homework-apache --network host httpd:2.4-alpine | Out-Null
if (-not (Wait-ForContent "http://localhost:80" "It works!")) { throw "Apache did not return the expected page on localhost:80" }
Write-Host "PASS: Apache host-network page is available on port 80."

docker pull nginx:alpine
@"
<!doctype html>
<html lang="en">
    <head><meta charset="utf-8"><title>Docker bind mount</title></head>
    <body><h1>Hello students</h1></body>
</html>
"@ | Set-Content .\bind-mount\index.html -NoNewline
docker run -d --name homework-volume-nginx -p 8088:80 -v "${PWD}\bind-mount:/usr/share/nginx/html:ro" nginx:alpine | Out-Null
if (-not (Wait-ForContent "http://localhost:8088" "Hello students")) { throw "Initial bind-mount content was not served" }
(Get-Content .\bind-mount\index.html -Raw).Replace("Hello students", "Hello students - updated") | Set-Content .\bind-mount\index.html -NoNewline
if (-not (Wait-ForContent "http://localhost:8088" "Hello students - updated")) { throw "Updated bind-mount content was not served" }
Write-Host "PASS: bind-mount content changed without restarting Nginx."