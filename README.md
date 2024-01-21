## CREAR IMAGEN

```shell
docker build -t image_name .
```


## CREAR CONTENEDOR
```shell
docker run -d -p 22100-22110:22100-22110 -p 30:20 -p 31:21 -p 82:8081 -u root --name container_name image_name
```

## CONFIGURACIONES
```shell
-p 30:20   # Es el puerto de FTP (En este caso se redirige el puerto *20* del contenedor al puerto *30* del servidor)
```
```shell
-p 31:21   # Es el puerto de FTP (En este caso se redirige el puerto *21* del contenedor al puerto *31* del servidor)
```
```shell
-p 82:8081 # Es el puerto de Node.js (En este caso se redirige el puerto *8081* del contenedor al puerto *82* del servidor)
```