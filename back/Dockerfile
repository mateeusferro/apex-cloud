FROM node:22-alpine AS build

RUN apk update && apk upgrade
WORKDIR /app

COPY . .

RUN npm install

EXPOSE 8080

CMD ["node", "index.js"]
