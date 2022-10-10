FROM nginx:alpine
ARG CLUSTER_COLOUR
RUN echo "<h1>Welcome to the $CLUSTER_COLOUR Cluster!</h1>" > /usr/share/nginx/html/index.html
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
