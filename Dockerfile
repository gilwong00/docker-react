FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN yarn
COPY . .
RUN yarn build

FROM nginx
# exposes a port for elastic beanstalk
EXPOSE 80
# copies build folder generated by builder phase into ngnix folder
COPY --from=0 /app/build /usr/share/nginx/html
# the default command of the nginx container is to start the server so we don't need to specific a start command