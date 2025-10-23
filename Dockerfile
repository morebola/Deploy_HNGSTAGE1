# Use Python 3.11 image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy all files into container
COPY . /app

# Install Flask (simple web framework)
RUN pip install flask

# Expose port 8000
EXPOSE 8000

# Run a simple Flask app
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=8000"]
