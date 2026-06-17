FROM node:20.18.3-alpine3.21 AS build
# alpine image is nodejs distribution, light weight image

WORKDIR /app/backend
# creating a directory and copying the application files into a directory

COPY package.json .
COPY *.js .
RUN npm install



#copying the artifacts from build into runner 
FROM node:20.18.3-alpine3.21
RUN addgroup -S expense && adduser -S expense -G expense && \
    
    mkdir -p /app/backend && \
    chown -R expense:expense /app/backend

ENV DB_HOST="mysql"
WORKDIR /app/backend
USER expense 
COPY --from=build /app/backend  /app/backend

CMD ["node" , "index.js"]
