FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY app.js .

RUN chown -R node:node /app

# Use numeric UID:GID to pass Hadolint DL3066
USER 1000:1000

EXPOSE 80

# Native healthcheck using Node's http module
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
  CMD ["node", "-e", "require('http').get('http://localhost:80/', (r) => process.exit(r.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"]

CMD ["node", "app.js"]
