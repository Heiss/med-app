FROM node:15.8-alpine3.10 AS web
WORKDIR /web
RUN apk add gettext make
COPY package*.json ./
RUN npm install && npm install --only=dev
COPY . .
RUN make l10n-compile
RUN npm run build

FROM python:3.8-alpine
COPY requirements.txt /app/requirements.txt
ENV SET_MAX_VISITOR_NUMBER="1"

WORKDIR /app
RUN pip install -r requirements.txt

COPY --from=web /web/dist ./dist
COPY server.py /app
EXPOSE 5000/tcp
