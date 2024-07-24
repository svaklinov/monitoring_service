FROM python:3-slim AS build

WORKDIR /usr/src/app

# Set TERM environment variable
ENV TERM xterm

COPY . .

# Create a virtual environment and install dependencies
RUN python3 -m venv /venv && \
     /venv/bin/pip install --upgrade pip && \
     /venv/bin/pip install psutil && \
     /venv/bin/pip install -r requirements.txt

# Use a smaller base image for the final stage
FROM python:3-slim-bullseye

WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /venv /venv
COPY --from=build /usr/src/app /usr/src/app

# Expose port for Flask
EXPOSE 5000

CMD ["/venv/bin/python3", "./app.py"]