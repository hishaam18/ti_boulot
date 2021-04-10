//importing a module from node.js
const http = require("http");

//importing a file into node.js
const app = require("./app");

//defining a port number
const port = 9000;

//create a http server with 'app' as parameter
const server =http.createServer(app);

//wait for a connection
server.listen(port);
