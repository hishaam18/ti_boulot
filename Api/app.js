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


//---------------------------------Register----------------------------------------//

app.use("/register", function (req, res, next) {

    console.log(req.body);

    var User_ID = req.body.User_ID;
    var firstName = req.body.firstName;
    var lastName = req.body.lastName;
    var emailAddress = req.body.emailAddress;
    var location = req.body.location;
    var password = req.body.password;
    var accountType = req.body.accountType;
    var Worker_ID = req.body.Worker_ID;
    var occupation = req.body.occupation;
    var experience = req.body.experience;

    registerUser(firstName, lastName, emailAddress, location, password, accountType, occupation, experience).then(result => {
    });

}); //localhost:9000/registerUser

async function registerUser(firstName, lastName, emailAddress, location, password, accountType, occupation, experience) {

    let sql = "INSERT INTO user VALUES (Default ,'" + firstName + "','" + lastName + "','" + emailAddress + "','" + location + "','" + password + "','" + accountType + "', 'null' ); SET @last_id =  LAST_INSERT_ID(); INSERT INTO worker VALUES (DEFAULT, @last_id ,'" + occupation + "','" + experience + "');"

    console.log(sql);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                resolve(err.code);
            } else {
                console.log(result);
                resolve(1);
            }
        })

    });

}

//---------------------------------Login----------------------------------------//

app.use("/login", function (req, res, next) {

    var emailAddress = req.body.emailAddress;
    var password = req.body.password;


/* The function below is calling the checkValidLogIn function: 

What the checkValidLogIn does:-  see comments  above the checkValidLogIn far below, not this one.

This function takes as parameters emailAddress and password.

'result' is received from the checkValidLogIn function and contains emailAddress and password.


if result = 1 , that is if the result contains the 2 arguments (emailAddress and password):

    getUserID() is called -  see comments of the function far below(not immediate) 
    then: 

    if:- result=0 that is the result does not contain a stringified User_ID,    
        - json sent to UI/Flutter 
            -success false
            -error message displayed in UI console
            -data - map form 
            -msg
    else:-
        that is if result =1, 'result' contains a User_ID, 
            -json is sent to flutter
            -success true
            -error message null
            -data- User_ID

if result = 0, that is the result contains the 2 arguments(emailAddress, password)

     checkValidEmailAddress() is called -  see comments of the function far below(not immediate) 

    if:- result = 1, that is the email correponds,
       send json: error message password does not match

         result =0, that is email cannot be found in database,
         send json, error message, account downt exist
            
*/

    checkValidLogIn(emailAddress, password).then(result => {


        if (result == 1) {

            getUserID(emailAddress).then(result => {

                if (result == 0) {
                    res.status(200).json({
                        success: false,
                        error: "Failed to get User ID",
                        data: {},
                        msg: ""
                    });
                } else {
                    res.status(200).json({
                        success: true,
                        error: "",
                        data: {
                            "User_ID": result,
                        },
                        msg: ""
                    });
                }
            });


        } else if (result == 0) {

            checkValidEmailAddress(emailAddress).then(result => {

                if (result == 1) {
                    res.status(200).json({
                        success: false,
                        error: "Password does not match!",
                        data: {},
                        msg: ""
                    });
                } else if (result == 0) {
                    res.status(200).json({
                        success: false,
                        error: "Account does not exist!",
                        data: {},
                        msg: ""
                    });
                }

            });
        }

    });


});


/* 

makes sql query to select user_id  of corresponding emailAddress

reject:- outputs Error message + user_id in console

resolve:- transforms  the User_ID from varchar to String and storesit in  result

'result' is then sent to the function above:- where getUserID function is called in - where checkValidLogIn is called

*/


//get User_ID
async function getUserID(emailAddress) {

    let sqlQuery = "SELECT User_ID FROM user WHERE Email='" + emailAddress + "';"

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                result = JSON.stringify(result[0].User_ID);
                resolve(result);
            }
        });

    });
}

/* Runs an sql query which takes existing Email and Password from the database 

what the promise does:-
    1. reject
        outputs error message + query error in console
    2. resolve 
        sends 'result'- which contains email and password, back to where this function was called, ie above. ^
*/

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

/* 
sql query: select all from corresponding email

what the promise does:-
    1. reject
    outputs error message + query error in console

    2. resolve 
    results contain all user details corresponding to the email.
*/

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


//---------------------------------postTask----------------------------------------//

app.use("/postTask", function (req, res, next) {

    console.log(req.body);

    var task_ID = req.body.task_ID;
    var User_ID = req.body.User_ID;
    var title = req.body.title;
    var task_description = req.body.task_description;
    var lat = req.body.lat;
    var lng = req.body.lng;
    var budget = req.body.budget;
    var displayDate = req.body.displayDate;
    var displayDeadlineDate = req.body.displayDeadlineDate;

   //console.log(User_ID)


  

        postTaskFunction(User_ID, title, task_description, lat, lng, budget, displayDate, displayDeadlineDate).then(result => {

            if (result == 0) {
                res.status(200).json({
                    success: false,
                    error: "Failed to post task",
                    data: {},
                    msg: ""
                });
            } else {
                res.status(200).json({
                    success: true,
                    error: "",
                    data: {
                        "Posted_data": result,
                    },
                    msg: ""
                });
            }


        });
    

});

async function postTaskFunction(User_ID, title, task_description, lat, lng, budget, displayDate, displayDeadlineDate) {

    let sql = "INSERT INTO task VALUES (Default ,'" + User_ID + "','" + title + "','" + task_description + "','" + lat + "', '" + lng + "','" + budget + "','" + displayDate + "','" + displayDeadlineDate + "');"

    console.log(sql);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                resolve(err.code);
            } else {
                console.log(result); // result = all the data posted
                resolve(1);
            }
        })
    });

}



//---------------------------------retrieveTask----------------------------------------//


app.use("/retrieveTask", function (req, res, next)  {    


    retrieveTaskFunction().then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get task_data",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: {
                    "task_data": result,
                },
                msg: ""
            });
        }
    });
    

});


    async function retrieveTaskFunction() { 

        let sql = "SELECT * FROM task;"

        console.log(sql);

        return new Promise((resolve, reject) => {

            pool.query(sql, (err, result) => {
                if (err) {
                    reject("Error executing the query: " + JSON.stringify(err));
                    resolve(0);
                } else {
                    resolve(result);
                }
            });
    
        });

    }





module.exports = app;



