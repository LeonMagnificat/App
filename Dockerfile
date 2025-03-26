FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary files
COPY src/ ./src/
COPY models/ ./models/

# Set environment variables
ENV PYTHONPATH=/app
ENV MODEL_PATH=/app/models/plant_disease_model.keras

# Set working directory to src
WORKDIR /app/src

# Command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]