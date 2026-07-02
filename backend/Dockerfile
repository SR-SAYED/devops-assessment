# Use a lightweight Python image
FROM python:3.12-slim

# Prevent Python from creating .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Ensure logs are written immediately
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy dependency file first (better Docker layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

# Expose application port
EXPOSE 8080

# Start the application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]