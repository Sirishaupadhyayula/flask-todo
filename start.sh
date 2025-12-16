#!/bin/sh
set -e

echo "Initializing database..."
python - <<EOF
from app import app, db
with app.app_context():
    db.create_all()
print("DB ready")
EOF

echo "Starting Gunicorn..."
exec gunicorn --bind 0.0.0.0:5000 app:app
