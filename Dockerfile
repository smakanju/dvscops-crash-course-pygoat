# Use the official Python image as the base image
FROM python:3.11.0b1-buster

# Set the working directory in the container
WORKDIR /app

# Install dependencies for psycopg2
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    dnsutils \
    libpq-dev \
    python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Expose the port the application runs on
EXPOSE 5000

# Define the command to run the application
CMD ["flask", "run"]
