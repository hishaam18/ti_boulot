//importing modules from and into node.js
const express = require("express");
const pool = require("./database_connection");
const bodyParser = require("body-parser");
const app = express();
const nodemailer = require('nodemailer');
const { response } = require("express");
const { resolveContent } = require("nodemailer/lib/shared");

//setting up the 'app'
app.use(bodyParser.urlencoded());//converts data into 'body' which can be used later on

//header indicates whether the response can be shared with requesting code from the given origin
//this will accept requests from the source (the links allocated)
app.use(function (req, res, next) {

    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
}
);

app.use("/register", function (req, res, next) {

    console.log(req.body); 

    var User_ID = req.body.User_ID
    var firstName = req.body.firstName;
    var lastName = req.body.lastName;
    var emailAddress = req.body.emailAddress;
    var location = req.body.location;
    var password = req.body.password;
    var accountType = req.body.accountType;
    var Worker_ID =req.body.Worker_ID;
    var occupation = req.body.occupation;
    var experience = req.body.experience;

registerUser(firstName, lastName, emailAddress, location, password, accountType, occupation, experience).then(result=> {
});


}); //localhost:9000/registerUser

async function registerUser(firstName, lastName, emailAddress, location, password, accountType, occupation, experience) {

let sql = "INSERT INTO user VALUES (Default ,'" + firstName + "','" + lastName + "','" + emailAddress + "','" + location + "','"+ password + "','" + accountType + "', 'null' ); SET @last_id =  LAST_INSERT_ID(); INSERT INTO worker VALUES (DEFAULT, @last_id ,'" + occupation + "','" + experience + "');"

console.log(sql);
return new Promise((resolve, reject) =>  {

    pool.query(sql, (err, result)=> {
        if (err) {
            console.log(err);
            resolve(err.code);
        }else { 
            console.log(result);
            resolve(1);
        }
    } )
});
}


app.use("/login", function (req, res, next) { 

    var emailAddress = req.body.emailAddress;
    var password = req.body.password;

    checkValidLogIn(emailAddress, password).then(result => {

        if (result == 1) {
            res.status(200).json({
                success: true,
                error: "",
                data: "",
                msg: ""
            });
        } else if (result == 0) {

            checkValidEmailAddress(emailAddress).then(result => {

                if (result == 1) {
                    res.status(200).json({
                        success: false,
                        error: "Password does not match!",
                        data: "",
                        msg: ""
                    });
                } else if (result == 0) {
                    res.status(200).json({
                        success: false,
                        error: "Account does not exist!",
                        data: "",
                        msg: ""
                    });
                }

            });

        }

    });

}); 

async function checkValidLogIn(emailAddress, password) {

    let sqlQuery = "SELECT EXISTS(SELECT * FROM user WHERE Email = '" + emailAddress + "' AND Password = '" + password + "') AS result;"

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
            } else {
                result = JSON.stringify(result[0].result);
                resolve(result);
            }
        });

    });

}

async function checkValidEmailAddress(emailAddress) {

    let sqlQuery = "SELECT EXISTS(SELECT * FROM user WHERE Email = '" + emailAddress + "') AS result;"

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
            } else {
                result = JSON.stringify(result[0].result);
                resolve(result);
            }
        });

    });

}



module.exports = app;



