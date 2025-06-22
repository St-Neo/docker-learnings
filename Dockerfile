# #base image

# FROM node:latest

# WORKDIR /app

# #first dot =COPY everything form current folder ie the week 15 folder second dot= into the working direcory of the image 
# COPY . .  


# #just builds the app ie bootstrap your app.
# RUN npm i
# RUN npm run build
# RUN npx prisma generate

# EXPOSE 3000

# #runs when you start the container 
# CMD [ "node","dist/index.js" ] 

#docker images
#docker run -d -p 3000:3000 my-docker-learnings

#docker build -t my-docker-learnings .

#docker exec to execute commands inside the container

#to perpetually run commands inside docker container docker exec -it (iterative mode) containerid /bin/bash
#to get container id run docker ps
#docker kill containerid

#27017:27018 explaining the host port and container port
#host port is the port of your macihhe This flag is used for port mapping. 
#It maps the container's port 27017 (the default port for MongoDB) to the host's port 27018. 
#This means that you can access the MongoDB instance running inside the container from the host machine using the port 27018.

#each step is a layer and each layer is cached


#optimized docker file for caching onlly when changes are made to migrations or packages and not the source code


FROM node:latest

WORKDIR /app

#expensive operation needs to be cached
COPY package* .
COPY ./prisma .

RUN  npm i
RUN npx prisma generate

#changes the most hence defer it to the end
COPY . .

RUN npm run build

EXPOSE 3000

CMD [ "node","dist/index.js" ] 

 
#to make contaiiners talk to each other we need a network
#volume: even if container crashes volume persists

#docker volume cresate volume name
#docker volume ls
#docker run -v volume_mongo:data/db -p 27017:27017
#data/db is the folder where data is persisited


#local host on a docker means its own netwoek and not the netwoek of the host machine