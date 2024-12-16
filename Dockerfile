# Use an official Python runtime as the base image
FROM python:3.9-slim as base

# Set the working directory in the container
WORKDIR /app

# Install required system packages and clean up
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       gcc \
       default-libmysqlclient-dev \
       pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Use a non-root user for security
RUN useradd -m appuser
USER appuser

# Specify the command to run the application
CMD ["python", "app.py"]
