### STAGE 1: Build ###
FROM node:16.14.0-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
#RUN pushd ./build
#RUN npm run build
#RUN npm run ng build -- --prod --configuration $env --output-path=/result
RUN npm run ng build --output-path=/result
#RUN popd
### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /result /usr/share/nginx/html
