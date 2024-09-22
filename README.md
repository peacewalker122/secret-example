# Introduction
This project were intended to mimic the process of the deployment with secret.

# How it works
The application itself is designed to have the `.env.enc` exist on the container. And then decrypted on startup. The decryption process weren't come from the applicatio.Instead it happen on the container entrypoint, decrypt the encrypted `.env` file, export all of the variable and then remove the `.env` file

> [!NOTE]
> The `ENCRYPTION_KEY` should be set when running the container. If you using secret manager such as docker secret manager, you can refer to the [Documentation](https://docs.docker.com/engine/swarm/secrets/) and setup the [entrypoint](./entrypoint.sh) accordingly.

# Usage
## Build Docker
```bash
docker build -t secret-example .
```

## Run
```bash
docker run --name secret-example -e ENCRYPTION_KEY=${YOUR_ENCRYPTION_KEY} -v /path/into/encrypted.env:/app/.env.enc -d secret-example:latest
```
