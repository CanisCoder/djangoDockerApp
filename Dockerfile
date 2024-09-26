# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy only the Django project files from the 'mysite' directory
COPY ./mysite /app

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Expose port 8000 for the Django app
EXPOSE 8000

# Define the entrypoint for the container
ENTRYPOINT ["/app/entrypoint.sh"]

# The command to run the Django application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "mysite.wsgi:application"]
