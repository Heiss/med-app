FROM node:15.8-alpine3.10 AS web
WORKDIR /web
ADD . /web
RUN apk add gettext make
RUN npm install && npm install --only=dev
RUN make l10n-compile
RUN npm run build

FROM python:3.8-alpine
WORKDIR /app

ENV SET_MAX_VISITOR_NUMBER="1"

COPY --from=web /web/dist ./dist
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD server.py /app
EXPOSE 5000/tcp

ENTRYPOINT [ "python", "server.py" ]