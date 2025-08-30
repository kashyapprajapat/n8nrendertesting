# Simply use the official n8n image
FROM n8nio/n8n:latest

# Set environment variables for Render deployment
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Expose the port
EXPOSE 5678