# Bussines Case Backend - MERU

Prueba técnica para puesto de desarrollador Backend

## Pre-requisitos

Asegúrate de tener los siguientes pre-requisitos antes de comenzar:

- Ruby 3.0.1
- PostgreSQL
- Rails 6.1.7.6

## Configuración del Entorno

### Ubuntu

Sigue estos pasos en sistemas Ubuntu:

1. Ejecuta `bundle install` para instalar las dependencias (gemas).
2. Verifica si el servicio de PostgreSQL está activo: `sudo service postgresql status`.
3. Si el servicio no está activo, puedes iniciarlo con `sudo service postgresql start`, o según tu configuración, utiliza `systemctl`.
4. Debes crear el usuario `meru` con la contraseña que se encuentra en el archivo `.env`. Si ya tienes un usuario, reemplaza estos campos en `database.yml` y `.env` respectivamente.
5. Ejecuta `rails db:create` para crear la base de datos.
6. Ejecuta `rails db:migrate` para aplicar las migraciones.
7. Finalmente, puedes ejecutar las semillas con `rails db:seed`.

## Ejecución de Pruebas

Para correr los tests, utiliza el siguiente comando: `bundle exec rspec spec`

## Enlaces Útiles

[API para importar Requests de Postman](https://api.postman.com/collections/14416842-89c93c2b-0fff-41b3-9768-2276d839cfb5?access_key=PMAT-01HNMVRCK54W801CV9YMWWGDYE)

[Documentación de Postman publicada](https://documenter.getpostman.com/view/14416842/2s9YyvAzti)