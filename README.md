## 개발 환경

---
###환경  
~~~
Django + Mysql + Redis + FastApi + Nextjs
~~~

### 실행
~~~shell
docker-compose up
~~~

### .env
~~~
 - 내부 IP 및 PORT 설정
 - Main Database 설정
 - Django Celery 적용 여부
~~~

### docker-compose.yaml
~~~
master-db : Main Database 영역
redis : Redis 영역
backend-app : backend 영역 [current : Django 4.0.6]
api-app : api 영역 [ current : FastApi 0.78.0]
frontend-app : frontend 영역 [ current : node 16.x]
~~~

### docker
~~~
각 영역별 설정 파일
~~~

### logs
~~~
각 영역별 로그 파일
~~~

### data
~~~
Main Database Data Home [ 실행 시 생성 ] 
~~~

### backend
~~~
Backend Source Root [ 실행 시 생성 ]
~~~

### api
~~~
Api Source Root [ 실행 시 생성 ]
~~~

### frontend
~~~
Api Source Root [ 실행 시 생성 ]
~~~



