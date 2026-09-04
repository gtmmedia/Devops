FROM node:24-alpine AS dependencies

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev

FROM node:24-alpine

WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY package*.json server.js ./

EXPOSE 3000
CMD ["npm", "start"]