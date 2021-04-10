//Import the mysql module
const {createPool} = require('mysql');

//Create a connection pool with the user details
const Pool = createPool({
    multipleStatements: true,
    connectionLimit: 100,
    host: "localhost",
    user: "root",
    password: "",
    database: "database",

});

//export the pool so that 'app' can use the pool
module.exports =Pool;





