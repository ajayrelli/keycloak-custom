# # build environment
# FROM node:14-alpine as build
# WORKDIR /app
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile
# COPY . .
# RUN yarn build

# # production environment
# FROM nginx:stable-alpine
# COPY --from=build /app/build /usr/share/nginx/html
# COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
# CMD nginx -g 'daemon off;'

# FROM quay.io/keycloak/keycloak:latest                              
# COPY /build_keycloak/src/main/resources/theme /opt/keycloak/themes
FROM keycloak-theme:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=mysql

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build --transaction-xa-enabled=false

FROM keycloak-theme:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://10.101.32.5:3306/keycloak
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=Miracle@123
ENV KC_HOSTNAME_STRICT=false
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_PROXY=edge
ENV KC_HTTPS_PORT=443
# ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]