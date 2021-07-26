FROM nginx:latest

# COPY index.html /usr/share/nginx/html/

# COPY nginx.conf /etc/nginx/

RUN mkdir /etc/nginx/ssl

# COPY testaction.crt /etc/nginx/ssl/

# COPY testaction.key /etc/nginx/ssl/

ENV PORT=443

EXPOSE 443