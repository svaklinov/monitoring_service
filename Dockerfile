FROM python:3
#FROM python:3-slim

WORKDIR /usr/src/app
# Set TERM environment variable
ENV TERM xterm

COPY . .
# Create a virtual environment and install dependencies
RUN python3 -m venv /venv && \
     /venv/bin/pip install --upgrade pip && \
     /venv/bin/pip install psutil && \     
     /venv/bin/pip install -r requirements.txt

# Expose port for Flask
EXPOSE 5000

CMD ["/venv/bin/python3", "./app.py"]