#!/bin/bash

# Fetch decryption key from secret management service
DECRYPTION_KEY=${ENCRYPTION_KEY}

if [ -z "$DECRYPTION_KEY" ]; then
  DECRYPTION_KEY = $(cat /run/secrets/encryption_key)
fi

if [ -z "$DECRYPTION_KEY" ]; then
  echo "Error: No decryption key found"
  exit 1
fi

# Decrypt the .env file
openssl enc -aes-256-cbc -d -in /app/.env.enc -out .env -pass pass:$DECRYPTION_KEY
if [ $? -ne 0 ]; then
  echo "Error: Failed to decrypt .env file"
  exit 1
fi

# Export the environment variables
export $(cat .env | xargs)

# Remove the decrypted .env file
rm .env

# Start your main application
exec "$@"
