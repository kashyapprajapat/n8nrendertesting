# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node

# Switch to root to make changes
USER root

# Create data directory and set permissions
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

# Switch back to node user
USER node

# Expose the port n8n runs on
EXPOSE 5678

# Set environment variables for production
ENV NODE_ENV=production
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV GENERIC_TIMEZONE=UTC
# ENV WEBHOOK_URL will be set in Render dashboard after deployment

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz || exit 1

# Start n8n using the entrypoint from the base image
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["n8n"]