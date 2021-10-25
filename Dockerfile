FROM composer as vendor
COPY cms/composer.json composer.json
COPY cms/composer.lock composer.lock
RUN composer install --ignore-platform-reqs --no-interaction --prefer-dist

FROM craftcms/nginx:8.0
USER root
RUN apk add --no-cache mysql-client
USER www-data

COPY --chown=www-data:www-data --from=vendor /app/vendor/ /app/vendor/
COPY --chown=www-data:www-data . .
