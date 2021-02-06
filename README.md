# med-app


## Docker setup

````
docker run heiss/med:latest -p 8080:5000 SET_MAX_VISITOR_NUMBER=2
```

This command expose the docker container on port 8080 to the world and set the max number of visitors for a patient to 2. Change both to your needs.

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
