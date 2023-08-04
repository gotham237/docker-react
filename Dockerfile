FROM node:16-alpine as builder
USER node
RUN mkdir -p home/node/app
WORKDIR home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node . .
RUN npm run build


FROM nginx
#expose port for elastic beanstalk
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html
#nginx starts by itself so there is no need for running any commands

