# docker build --rm -f "Dockerfile" -t paulgilchrist/marketo-poc:latest .
# docker push paulgilchrist/marketo-poc
FROM --platform=linux/amd64 node:alpine
LABEL author="Paul Gilchrist"
RUN mkdir /src
RUN mkdir /src/marketo-poc
COPY ./package.json /src/marketo-poc/
COPY ./server.js /src/marketo-poc/
RUN mkdir /src/marketo-poc/swagger
COPY ./swagger /src/marketo-poc/swagger
WORKDIR /src/marketo-poc
EXPOSE 80
EXPOSE 443
RUN npm i
ENTRYPOINT ["node", "server.js"]
# Optional troubleshooting commands
#   docker run -d paulgilchrist/marketo-poc -p 8080:80 -e dmvapi=<url> -e edhapi=<url> -e edhapikey=<apiKey> -e munchkinid=<marketoMunchkinId>
#   or
#   kubectl apply -f kubernetes
# docker rm -f <containerID>
# ENTRYPOINT ["sleep", "infinity"] # This can keep the container running, so you can connect and troubleshoot
