# docker build --rm -f "Dockerfile" --no-cache --platform linux/arm64/v8 -t paulgilchrist/env-test:arm64v8 .
# docker push paulgilchrist/env-test:arm64v8
# docker build --rm -f "Dockerfile" --no-cache --platform linux/amd64 -t paulgilchrist/env-test:amd64 .
# docker push paulgilchrist/env-test:amd64
# docker manifest rm paulgilchrist/env-test:latest
# docker manifest create paulgilchrist/env-test:latest paulgilchrist/env-test:arm64v8 paulgilchrist/env-test:amd64
# docker manifest push paulgilchrist/env-test:latest
FROM --platform=linux/amd64 node:alpine
LABEL author="Paul Gilchrist"
RUN mkdir /src
RUN mkdir /src/env-test
COPY ./package.json /src/env-test/
COPY ./server.js /src/env-test/
RUN mkdir /src/env-test/swagger
COPY ./swagger /src/env-test/swagger
WORKDIR /src/env-test
EXPOSE 80
EXPOSE 443
RUN npm i
ENTRYPOINT ["node", "server.js"]

