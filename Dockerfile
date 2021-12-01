## Build Phase: install deps and build our app
FROM node:16-alpine as builder

RUN mkdir -p /home/usr/app
WORKDIR /home/usr/app
COPY --chown=node:node package.json .

# install dependencies
RUN npm install

COPY --chown=node:node . .

RUN npm run build

## Termination of previous block.
## Run Phase:
# a second base image
FROM nginx

# Copy result of npm run build
## we copy from different phase
COPY --from=builder /home/usr/app/build  /usr/share/nginx/html

# start nginx: just run a container from me ;)