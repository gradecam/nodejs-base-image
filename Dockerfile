# Use the alpine image so we have the smallest image possible
FROM nodesource/nsolid:carbon-latest

# Create `app` group and user since the base nodesource image
# doesn't currently.
RUN addgroup --gid 1000 app \
 && adduser --gid 1000 --uid 1000 --home /app --disabled-password app

USER app
WORKDIR /app
# These commands will get executed in the context of the build for the
# application container image.
# NOTE: copy the package.json file first because if it hasn't changed
# the cache will not be invalidated and thus the COPY and npm install
# will not introduce a new layer.
ONBUILD COPY package.json /app/package.json
ONBUILD RUN npm install --production
ONBUILD COPY . /app