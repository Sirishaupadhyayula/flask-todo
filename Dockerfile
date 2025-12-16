FROM python:3.11.14-slim
WORKDIR /app

# pip freeze > requirements.txt
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir gunicorn

# Copy the rest of the application code
COPY . .
RUN chmod +x /app/start.sh

# Environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Expose the port the app runs on
EXPOSE 5000

# Start the app with Gunicorn
CMD ["/app/start.sh"]
