h1. Small and Simplified Node.js Containers w/ N|Solid

A base image based off of the `nodesource/nsolid:alipne` image. Intended use is as a common base image for Node.js container images which are as small as possible. If your project requires modules which require compilation you will likely need to use a different image to build your container.

Specific areas of interest might be using the builder pattern or multi-stage builds which were announced at Dockercon 2017.

h2. Base Image Triggers

When using this base image immediately after your `FROM` command the build triggers defined in this image will execute. These triggers will cause `package.json` to be copied and then execute `npm install --production`. These are done to cache your package dependencies. If there are no changes to your `package.json` file the cache will not be invalidated and your previously created layers should be reused.

h2. Environment and Users

An `app` is created by the base image with a home directory of `/app`. The base image switches to the `app` user and sets the `WORKDIR` to `/app`. You should copy your application files into this directory. (This is where your `package.json` file will have been copied to.) The `NodeSource` image used by this container sets `NODE_ENV` to `production`.

h2. TypeScript Projects

You should complile your TypeScript projects to JavaScript prior to packaging them into a container. Failure to do so can result in undesirable behavior as your files are compiled on the fly during execution. Save yourself some trouble and always deploy the JavaScript version of the files.
