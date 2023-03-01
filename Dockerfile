# From base image node 16 specified version to avoid bugs and as builder as its alias
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# this also terminates previous process
FROM nginx 
COPY --from=builder /app/build  /usr/share/nginx/html
