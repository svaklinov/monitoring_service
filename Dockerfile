# Use a minimal base image
FROM python:3.11-alpine AS build

WORKDIR /usr/src/app
# Set TERM environment variable
ENV TERM=xterm

# Install build dependencies
RUN apk add --no-cache build-base linux-headers python3-dev

COPY . .

# Create a virtual environment and install dependencies
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install psutil && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt

# Use a smaller base image for the final stage
FROM python:3.11-alpine

# Create the user without setting a password
RUN adduser -D appuser

# Running as a non-root user enhances security by limiting the potential impact of security vulnerabilities
USER appuser

WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /venv /venv
COPY --from=build /usr/src/app /usr/src/app

# Expose port for Flask
EXPOSE 5000

CMD ["/venv/bin/python3", "./app.py"]