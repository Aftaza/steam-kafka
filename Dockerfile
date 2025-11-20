FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    STEAM_API_KEY="" \
    FLASK_HOST=0.0.0.0 \
    FLASK_PORT=8080

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Create data directory
RUN mkdir -p /app/data/steam

# Expose dashboard port
EXPOSE 8080

# Default command (can be overridden)
CMD ["python", "src/dashboard/app.py"]