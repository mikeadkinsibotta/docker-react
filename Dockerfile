# Get the node version of alpine.  Everything under FROM is tagged as builder.  
FROM node:alpine as builder
# Sets the working directory on the container
WORKDIR '/app'
# COPY the package.json file to the container
COPY package.json .
# Install the dependencies using the package.json file
RUN npm install
# Copy over all the code
COPY . .
# Create the production ready folder called build
RUN npm run build

# The second FROM says this is the end of the previously tagged block
FROM nginx
# Copy from the builder phase called build.  It is located in /app/build and put it in the /usr/share/nginx/html folder.
COPY --from=builder /app/build /usr/share/nginx/html
# We don't have to specify a run command because the default command on nginx will start up nginx for us.

