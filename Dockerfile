FROM python:3-slim AS build

WORKDIR /usr/src/app
# Set TERM environment variable
ENV TERM xterm

COPY . .

# Create a virtual environment and install dependencies
# Upgrade the package index and install security upgrades
RUN apt-get update && \
     apt-get upgrade -y && \
     apt-get autoremove -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/* && \
     python3 -m venv /venv && \
     /venv/bin/pip install --upgrade pip && \
     /venv/bin/pip install psutil && \
     /venv/bin/pip install --no-cache-dir -r requirements.txt

# Use a smaller base image for the final stage
FROM python:3-slim as final

#create the user without setting a password, if an attacker manages to exploit the application, they will have limited privileges and will not have access to the root user’s capabilities.
RUN adduser --disabled-password --gecos '' appuser

#Running as a non-root user enhances security by limiting the potential impact of security vulnerabilities..
USER appuser

WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /venv /venv
COPY --from=build /usr/src/app /usr/src/app

# Expose port for Flask
EXPOSE 5000

CMD ["/venv/bin/python3", "./app.py"]