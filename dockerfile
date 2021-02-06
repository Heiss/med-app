FROM node:15.8-alpine3.10 AS web
WORKDIR /web
ADD / .
RUN apk add gettext
RUN make l10n-compile
RUN npm install
RUN npm run build

FROM python:3.8-alpine
WORKDIR /app

ENV SET_MAX_VISITOR_NUMBER="1"

COPY --from=web /web/dist ./dist
RUN pip install -r requirements.txt
ADD /server.py .

ENTRYPOINT [ "python", "server.py" ]