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


    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(err.code);
            } else {
                // console.log(result);
                resolve(1
                );
            }
        })

    });

}

//---------------------------------Login----------------------------------------//

app.use("/login", function (req, res, next) {

    var emailAddress = req.body.emailAddress;
    var password = req.body.password;

    checkValidLogIn(emailAddress, password).then(result => {

        // console.log(result); //print user_id

        if (result == 1) {

            //calling getUserID function
            getUserID(emailAddress).then(result => {

                if (result == 0) {
                    res.status(200).json({
                        success: false,
                        error: "Failed to get User ID",
                        data: {},
                        msg: ""
                    });
                } else {

                    //calling getUserType function
                    getUserType(result).then(result => {

                        res.status(200).json({
                            success: true,
                            error: "",
                            data: {
                                "User_ID": result['User_Data']["User_ID"],
                                "Avatar_Path": result['User_Data']["Avatar_Path"],
                                "User_Type": result['User_Data']["User_Type"]
                            },
                            msg: ""
                        });

                    });


                }
            });



            //call new method here



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
getUserType function 

sqlQuery: if the corresponding User_ID exists in the table worker, (it returns true),
                                all data from worker table for that particular worker is selected and return as 'result'
                            
1) if User_ID doesnt exist,  error is returned
2) if User_ID exists, the following data is sent as result in method checkLogin, where getUserType method is called
    a) User_ID
    b) User_Type

*/

async function getUserType(User_ID) {

    let sqlQuery = "SELECT EXISTS(SELECT * FROM worker WHERE User_ID = '" + User_ID['User_ID'] + "') AS result;"

    return new Promise((resolve, reject) => {
        pool.query(sqlQuery, (err, result) => {

            if (err) {
                reject(JSON.stringify(err));
            } else {
                var data = {
                    "User_Data": User_ID,
                    //ternary operator-- represented below

                    // var x;
                    // if (result[0].result == 1) {
                    //     x ="worker";
                    // } else {
                    //     x = "user";
                    // }

                };
                data['User_Data']['User_Type'] = result[0].result == 1 ? "Worker" : "User";
                resolve(data);
            }
        });
    });


}







/* 

makes sql query to select user_id  of corresponding emailAddress

reject:- outputs Error message + user_id in console

resolve:- transforms  the User_ID from varchar to String and storesit in  result

'result' is then sent to the function above:- where getUserID function is called in - where checkValidLogIn is called

*/

//get User_ID
async function getUserID(emailAddress) {

    let sqlQuery = "SELECT User_ID, Avatar_Path FROM user WHERE Email='" + emailAddress + "';"

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                result = result[0];
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
    var task_ID = req.body.task_ID;
    var User_ID = req.body.User_ID;
    var title = req.body.title;
    var task_description = req.body.task_description;
    var lat = req.body.lat;
    var lng = req.body.lng;
    var budget = req.body.budget;
    var displayDate = req.body.displayDate;
    var displayDeadlineDate = req.body.displayDeadlineDate;
    var taskRating = 0; 
    var completed = false;
    var takenBy = null;

    postTaskFunction(User_ID, title, task_description, lat, lng, budget, displayDate, displayDeadlineDate, taskRating, completed, takenBy).then(result => {

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

async function postTaskFunction(User_ID, title, task_description, lat, lng, budget, displayDate, displayDeadlineDate, taskRating, completed, takenBy ) {

    let sql = "INSERT INTO task VALUES (Default ,'" + User_ID + "','" + title + "','" + task_description + "','" + lat + "', '" + lng + "','" + budget + "','" + displayDate + "','" + displayDeadlineDate + "','" + taskRating + "','" + completed + "','" + takenBy + "' );"

    // console.log(sql);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(err.code);
            } else {
                // console.log(result); // result = all the data posted
                resolve(1);
            }
        })
    });

}



//---------------------------------retrieveTask----------------------------------------//


app.use("/retrieveTask", function (req, res, next) {


    retrieveTaskFunction().then(result => {

        // console.log(result);


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
                    "task_data": result
                },
                msg: ""
            });
        }
    });


});


async function retrieveTaskFunction() {

    let sql = "SELECT * FROM task ORDER BY Task_ID desc;"

    // console.log(sql);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects
            }
        });

    });

}


//---------------------------------getMyTasks----------------------------------------//

app.use("/getMyTasks", function (req, res, next) {


    var User_ID = req.body.User_ID;
    // console.log(User_ID);

    getMyTasksFunction(User_ID).then(result => {

        // console.log(result);


        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get mytask_data",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: {
                    "mytask_data": result
                },
                msg: ""
            });
        }
    });
});

/* 

Contains query to select all tasks for the user 

returns result json object of all tasks for the logged in user

*/

async function getMyTasksFunction(User_ID) {

    let sql = " SELECT * FROM task WHERE User_ID = '" + User_ID + "' ORDER BY Task_ID Desc;"

    // console.log(sql);

    // console.log(User_ID);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects (list of myTasks)
            }
        });
    });

}


//--------------------------------------------- worker Send Offer ----------------------------------------------------//


app.use("/workerSendOffer", function (req, res, next) {



    // console.log(req.body);


    var user_ID = req.body.user_ID;
    var task_ID = req.body.task_ID;
    var taskUserID = req.body.task_User_ID;
    var offeringPrice = req.body.offeringPrice;
    var comment = req.body.comment;
    var workerDisplayDate = req.body.workerDisplayDate;
    var workerDeadlineDate = req.body.workerDeadlineDate;
    var timeStamp = req.body.timeStamp;

    sendOfferFunction(user_ID, task_ID, offeringPrice, comment, workerDisplayDate, workerDeadlineDate).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to send offer",
                data: {},
                msg: ""
            });
        } else {

            getConversation(user_ID, taskUserID).then(result => {

                if (result == -1) {
                    res.status(200).json({
                        success: false,
                        error: "Failed to get conversation",
                        data: {},
                        msg: ""
                    });
                }
                else if (result == 0) {
                    addToConversation(user_ID, taskUserID, timeStamp).then(result => {

                        if (result == 0) {
                            res.status(200).json({
                                success: false,
                                error: "Failed to add to conversation table",
                                data: {},
                                msg: ""
                            });
                        } else {
                            getConversationAndName(user_ID, taskUserID, task_ID).then(result => {


                                if (result == 0) {
                                    res.status(200).json({
                                        success: false,
                                        error: "Failed to update conversation table",
                                        data: {},
                                        msg: ""
                                    });
                                } else {
                                    addToMessage(result['conversationID'], user_ID, taskUserID, result['firstName'] + " " + result['lastName'] + " has offered to work for the task " + result['taskName'] + " at Rs" + offeringPrice, timeStamp).then(result => {
                                        if (result == 0) {
                                            res.status(200).json({
                                                success: false,
                                                error: "Failed to add to message table",
                                                data: {},
                                                msg: ""
                                            });
                                        } else {
                                            res.status(200).json({
                                                success: true,
                                                error: "Failed to send offer",
                                                data: {},
                                                msg: ""
                                            });
                                        }
                                    });
                                }


                            });
                        }

                    });
                } else {
                    updateConversation(result, timeStamp).then(result => {

                        if (result == 0) {
                            res.status(200).json({
                                success: false,
                                error: "Failed to update conversation table",
                                data: {},
                                msg: ""
                            });
                        } else {

                            getConversationAndName(user_ID, taskUserID, task_ID).then(result => {


                                if (result == 0) {
                                    res.status(200).json({
                                        success: false,
                                        error: "Failed to update conversation table",
                                        data: {},
                                        msg: ""
                                    });
                                } else {
                                    addToMessage(result['conversationID'], user_ID, taskUserID, result['firstName'] + " " + result['lastName'] + " has offered to work for the task " + result['taskName'] + " at Rs" + offeringPrice, timeStamp).then(result => {
                                        if (result == 0) {
                                            res.status(200).json({
                                                success: false,
                                                error: "Failed to add to message table",
                                                data: {},
                                                msg: ""
                                            });
                                        } else {
                                            res.status(200).json({
                                                success: true,
                                                error: "Failed to send offer",
                                                data: {},
                                                msg: ""
                                            });
                                        }
                                    });
                                }


                            });


                        }



                    });
                }
            });



        }


    });

});


async function sendOfferFunction(User_ID, task_ID, offeringPrice, comment, workerDisplayDate, workerDeadlineDate) {

    let sqlQuery = "INSERT INTO offer VALUES (Default,'" + User_ID + "','" + task_ID + "','" + offeringPrice + "','" + comment + "','" + workerDisplayDate + "','" + workerDeadlineDate + "');"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(err.code);
            } else {
                // console.log(result); // result = all the data in offer
                resolve(1);
            }
        })
    });

}

async function getConversation(user_ID, taskUserID) {

    let sqlQuery = "SELECT * FROM Conversation WHERE (Recipient_One = '" + user_ID + "' AND Recipient_Two = '" + taskUserID + "') OR (Recipient_One = '" + taskUserID + "' AND Recipient_Two = '" + user_ID + "');"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(-1);
            } else {
                if (result.length == 0) {
                    resolve(0);
                } else {
                    //  console.log(result[0]['Conversation_Id']); // result = all the data in offer
                    resolve(result[0]['Conversation_Id']);
                }

            }
        })
    });

}

async function getConversationAndName(user_ID, taskUserID, task_ID) {

    let sqlQuery = "SELECT (SELECT Conversation_ID FROM Conversation WHERE (Recipient_One = '" + user_ID + "' AND Recipient_Two = '" + taskUserID + "') OR (Recipient_One = '" + taskUserID + "' AND Recipient_Two = '" + user_ID + "'))  as conversationID, (SELECT First_Name FROM User WHERE User_ID = '" + user_ID + "' )  as firstName , (SELECT Last_Name FROM User WHERE User_ID = '" + user_ID + "')  as lastName, (SELECT Title FROM Task WHERE Task_ID = '" + task_ID + "')  as taskName;"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(err.code);
            } else {
                if (result.length == 0) {
                    resolve(0);
                } else {
                    //  console.log(result[0]); // result = all the data in offer
                    resolve(result[0]);
                }

            }
        })
    });

}

async function updateConversation(conversationID, timeStamp) {

    let sqlQuery = "UPDATE Conversation SET Timestamp = '" + timeStamp + "' WHERE Conversation_ID = '" + conversationID + "';"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(0);
            } else {
                // console.log(result); // result = all the data in offer
                resolve(1);
            }
        })
    });

}

async function addToConversation(recipientOne, recipientTwo, timeStamp) {

    let sqlQuery = "INSERT INTO Conversation VALUES (Default, '" + recipientOne + "', '" + recipientTwo + "', '" + timeStamp + "');"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(0);
            } else {
                // console.log(result); // result = all the data in offer
                resolve(1);
            }
        })
    });

}

async function addToMessage(conversationID, senderID, receiverID, message, timeStamp) {

    let sqlQuery = "INSERT INTO Message VALUES(Default, '" + conversationID + "', '" + senderID + "', '" + receiverID + "', '" + message + "', '" + timeStamp + "');"

    // console.log(sqlQuery);

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {
            if (err) {
                // console.log(err);
                resolve(0);
            } else {
                // console.log(result); // result = all the data in offer
                resolve(1);
            }
        })
    });

}

//--------------------------------------------- GET CHAT LIST ----------------------------------------------------//

app.use("/getChatListForUser", function (req, res, next) {

    var User_ID = req.body.User_ID;
    var timeZoneOffset = req.body.timeZoneOffset;

    getChatListForUser(User_ID, timeZoneOffset).then(result => {

        if (result == -1) {
            res.status(200).json({
                success: false,
                error: "Failed to get User details",
                data: {},
                msg: ""
            });
        } else {


            res.status(200).json({
                success: true,
                error: "Failed to get User details",
                data: result,
                msg: ""
            });



        }

    });

});


async function getChatListForUser(User_ID, timeZoneOffset) {

    let sql = "SELECT user.User_ID, user.First_Name, user.Last_Name, user.Avatar_Path, convo.Conversation_Id, ADDTIME(convo.Timestamp, '" + timeZoneOffset + "') AS Timestamp FROM user INNER JOIN conversation AS convo on convo.Recipient_One = user.User_ID WHERE convo.Recipient_Two = '" + User_ID + "' UNION SELECT user.User_ID, user.First_Name, user.Last_Name, user.Avatar_Path, convo.Conversation_Id,  ADDTIME(convo.Timestamp, '" + timeZoneOffset + "') AS Timestamp FROM user INNER JOIN conversation AS convo on convo.Recipient_Two = user.User_ID WHERE convo.Recipient_One = '" + User_ID + "';";

    // console.log(sql);

    // console.log(User_ID);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err)
                // reject("Error executing the query: " + JSON.stringify(err));
                resolve(-1);
            } else {
                // console.log(result)
                resolve(result); //result contains an array of json objects (firstname and lastname of user)
            }
        });
    });


};



//--------------------------------------------- MESSAGING ----------------------------------------------------//

app.use("/getUserDetails", function (req, res, next) {

    var User_ID = req.body.User_ID;


    getUserDetailsFunction(User_ID).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get User details",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: {
                    "userDetails_data": result,
                },
                msg: ""
            });
        }

    });

});


async function getUserDetailsFunction(User_ID) {

    let sql = " SELECT First_Name, Last_Name FROM user WHERE User_ID = '" + User_ID + "';"

    // console.log(sql);

    // console.log(User_ID);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects (firstname and lastname of user)
            }
        });
    });


};

/* -------------------------------- get avatar for user  ----------------------*/



app.use("/getAvatarForUser", function (req, res, next) {

    var userID = req.body.userID;


    getAvatarForUser(userID).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get User details",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: result,
                msg: ""
            });
        }

    });

});


async function getAvatarForUser(userID) {

    let sql = " SELECT Avatar_Path FROM user WHERE User_ID = '" + userID + "';";

    // console.log(sql);

    // console.log(User_ID);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects (firstname and lastname of user)
            }
        });
    });


};

/* ---------------------------------- Conversation for a user ---------------------------------*/

app.use("/getChatFromConversationID", function (req, res, next) {


    var conversationID = req.body.conversationID;

    getChatFromConversationID(conversationID).then(result => {
        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: result,
                msg: ""
            });
        }
    });

});

async function getChatFromConversationID(id) {
    let sqlQuery = "SELECT * FROM message WHERE Conversation_ID = '" + id + "';";

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {

            if (err) {
                resolve(0);
            } else {
                // console.log(result)
                resolve(result);
            }

        });

    });

}

/* -------------------------------- get chat list ----------------------*/

app.use("/sendMessage", function (req, res, next) {


    var conversationID = req.body.conversationID;
    var senderID = req.body.senderID;
    var message = req.body.message;
    var timestamp = req.body.timestamp;

    getReceiverID(conversationID, senderID, message, timestamp).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "",
                data: {},
                msg: ""
            });
        } else {

            sendMessage(conversationID, senderID, result, message, timestamp).then(result => {


                if (result == 0) {
                    res.status(200).json({
                        success: false,
                        error: "",
                        data: {},
                        msg: ""
                    });
                } else if (result == 1) {

                    setConversationTimestamp(conversationID, timestamp).then(result => {

                        if (result == 0) {
                            res.status(200).json({
                                success: false,
                                error: "",
                                data: {},
                                msg: ""
                            });
                        } else if (result == 1) {
                            res.status(200).json({
                                success: true,
                                error: "",
                                data: {},
                                msg: ""
                            });
                        }

                    });

                }

            });

        }

    });


});

async function getReceiverID(conversationID, senderID, message, timestamp) {

    let sql = "SELECT * FROM conversation WHERE (Conversation_ID = '" + conversationID + "' AND Recipient_One = '" + senderID + "') OR (Conversation_ID = '" + conversationID + "' AND Recipient_Two = '" + senderID + "');";
    // console.log(sql);

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                resolve(err.code);
            } else {
                resolve(result[0]['Recipient_One'] == senderID ? result[0]['Recipient_Two'] : result[0]['Recipient_One']);
            }
        })

    });

}


async function setConversationTimestamp(conversationID, timestamp) {

    let sql = "UPDATE conversation SET Timestamp = '" + timestamp + "' WHERE Conversation_ID = '" + conversationID + "';"

    // console.log(sql);
    // console.log(sql);
    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                resolve(err.code);
            } else {
                // console.log(result);
                resolve(1);
            }
        })

    });

}

async function sendMessage(conversationID, senderID, receiverID, message, timestamp) {

    let sql = "INSERT INTO message VALUES (Default, '" + conversationID + "', '" + senderID + "', '" + receiverID + "', '" + message + "', '" + timestamp + "');"

    // console.log(sql);
    // console.log(sql);
    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                resolve(err.code);
            } else {
                // console.log(result);
                resolve(1);
            }
        })

    });

}

/* -------------------------------- get chat list ------------------------------------*/

app.use("/getChatUsers", function (req, res, next) {

    getChatUsers(req.body.id).then(result => {
        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: result,
                msg: ""
            });
        }
    });

});

async function getChatUsers(id) {
    let sqlQuery = "SELECT DISTINCT From_User_ID AS ID FROM message WHERE To_User_ID = '" + id + "' UNION SELECT DISTINCT To_User_ID AS ID FROM message WHERE From_User_ID = '" + id + "';";

    return new Promise((resolve, reject) => {

        pool.query(sqlQuery, (err, result) => {

            if (err) {
                resolve(0);
            } else {
                // console.log(result)
                resolve(result);
            }

        });

    });

}


//-------------------------------------- Save Rating ------------------------------------------//

app.use("/sendRating", function (req, res, next) {

    var User_ID = req.body.User_ID;
    var Worker_ID = req.body.worker_ID;
    var rating = req.body.rating;

    console.log(req.body);

    checkExistence(User_ID, Worker_ID, rating).then(result => {



        if (result == 1) {

            changeExistingRating(User_ID, Worker_ID, rating).then(result => {
                if (result == 1) {
                    res.status(200).json({
                        success: true,
                        error: "",
                        data: {},
                        msg: ""
                    });
                } else {
                    res.status(200).json({
                        success: false,
                        error: "Failed to update rating in database",
                        data: {},
                        msg: ""
                    });

                }
            });

        } else {

            sendRatingFunction(User_ID, Worker_ID, rating).then(result => {

                if (result == 1) {
                    res.status(200).json({
                        success: true,
                        error: "",
                        data: {},
                        msg: ""
                    });
                } else {
                    res.status(200).json({
                        success: false,
                        error: "Failed to insert rating in database",
                        data: {},
                        msg: ""
                    });

                }
            });

        }
    });


});



async function changeExistingRating(User_ID, Worker_ID, rating) {

    let sql = "Update rating SET Star_Rating = '" + rating + "' WHERE User_ID='" + User_ID + "' AND Worker_ID='" + Worker_ID + "' ;";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                resolve(err.code);
            } else {
                resolve(1
                );
            }
        })
    });


};


async function checkExistence(User_ID, Worker_ID, rating) {

    let sql = "SELECT EXISTS(SELECT * From rating WHERE User_ID='" + User_ID + "' AND Worker_ID='" + Worker_ID + "') as result";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                resolve(err.code);
            } else {

                resolve(result[0]['result']);
            }
        })
    });

}


async function sendRatingFunction(User_ID, Worker_ID, rating) {

    let sql = "INSERT INTO rating VALUES (Default,'" + User_ID + "','" + Worker_ID + "','" + rating + "');";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                resolve(err.code);
            } else {
                resolve(1
                );
            }
        })
    });

}

//---------------------------------------------------Display stars-----------------------------------------------------//


app.use("/displayRating", function (req, res, next) {

    var Worker_ID = req.body.Worker_ID;

    displayRatingFunction(Worker_ID).then(result => {

        if (result == 0) {

            res.status(200).json({
                success: false,
                error: "Could not select all from user",
                data: {},
                msg: ""
            });
        } else {

            res.status(200).json({
                success: true,
                error: "",
                data: result[0],
                msg: ""
            });

        }

    });

});

async function displayRatingFunction(Worker_ID) {

    let sql = "SELECT (SELECT First_Name FROM user WHERE User_ID = '" + Worker_ID + "') AS firstName,  (SELECT Last_Name FROM user WHERE User_ID = '" + Worker_ID + "') AS lastName,  (SELECT Email FROM user WHERE User_ID = '" + Worker_ID + "') AS emailAddress,  (SELECT Address FROM user WHERE User_ID = '" + Worker_ID + "') AS address, (SELECT AVG(Star_Rating) FROM rating WHERE Worker_ID = '" + Worker_ID + "') AS starRating;";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err)
                resolve(0);
            } else {
                resolve(result);
            }
        })
    });

};

// -----------------------------------------------------------Display Profile --------------------------------------------------------------//

app.use("/displayProfile", function (req, res, next) {


    var User_ID = req.body.User_ID;


    displayProfileFunction(User_ID).then(result => {

        if (result == 0) {

            res.status(200).json({
                success: false,
                error: "Could not select all from user",
                data: {},
                msg: ""
            });
        } else {

            res.status(200).json({
                success: true,
                error: "",
                data: result[0],
                msg: ""
            });

        }

    });

});

async function displayProfileFunction(User_ID) {

    let sql = "SELECT (SELECT First_Name FROM user WHERE User_ID = '" + User_ID + "') AS firstName,  (SELECT Last_Name FROM user WHERE User_ID = '" + User_ID + "') AS lastName,  (SELECT Email FROM user WHERE User_ID = '" + User_ID + "') AS emailAddress,  (SELECT Address FROM user WHERE User_ID = '" + User_ID + "') AS address, (SELECT AVG(Star_Rating) FROM rating WHERE Worker_ID = '" + User_ID + "') AS starRating;";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err)
                resolve(0);
            } else {
                resolve(result);
            }
        })
    });

};

// -----------------------------------------------------------Set avatar --------------------------------------------------------------//

app.use("/setAvatar", function (req, res, next) {


    var User_ID = req.body.User_ID;
    var Avatar_Path = req.body.Avatar_Path;


    setAvatar(User_ID, Avatar_Path).then(result => {

        if (result == 0) {

            res.status(200).json({
                success: false,
                error: "Could not set new avatar path",
                data: {},
                msg: ""
            });
        } else {

            res.status(200).json({
                success: true,
                error: "",
                data: {},
                msg: ""
            });

        }

    });

});

async function setAvatar(User_ID, Avatar_Path) {

    let sql = "UPDATE user SET Avatar_Path = '"+Avatar_Path+"' WHERE User_ID = '"+User_ID+"';";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err)
                resolve(0);
            } else {
                resolve(1);
            }
        })
    });

};


// ----------------------------------------------------------- sendTaskRating --------------------------------------------------------------//


app.use("/sendTaskRating", function (req, res, next) { 

var taskID = req.body.taskID;
var taskRating = req.body.taskRating;

sendTaskRatingFunction(taskID, taskRating).then(result => {

    if (result == 0) {

        res.status(200).json({
            success: false,
            error: "Could not return database response",
            data: {},
            msg: ""
        });
    } else {

        res.status(200).json({
            success: true,
            error: "",
            data: {},
            msg: ""
        });

    }

});



});



async function sendTaskRatingFunction(taskID, taskRating) {

    let sql = "UPDATE task SET Task_Rating = '"+taskRating+"', Completed = '"+true+"' WHERE Task_ID = '"+taskID+"';";

    return new Promise((resolve, reject) => {

        pool.query(sql, (err, result) => {
            if (err) {
                console.log(err)
                resolve(0);
            } else {
                resolve(1);
            }
        })
    });

};


//--------------------------------------------------- allTaskData------------------------------------------------------//


app.use("/allTaskData", function (req, res, next) { 

var taskID = req.body.taskID;
//console.log(taskID);

allTaskDataFunction(taskID).then(result => {

    //----------------------------
    if (result == 0) {
        res.status(200).json({
            success: false,
            error: "Failed to get all_task_data",
            data: {},
            msg: ""
        });
    } else {
        res.status(200).json({
            success: true,
            error: "",
            data: {
                "all_task_data": result
            },
            msg: ""
        });


    }

});

});

async function allTaskDataFunction(taskID) {

   let sqlQuery = "SELECT * FROM task WHERE Task_ID = '" + taskID + "'"

 //console.log(sqlQuery);

 return new Promise((resolve, reject) => {

    pool.query(sqlQuery, (err, result) => {
        if (err) {
            reject("Error executing the query: " + JSON.stringify(err));
            resolve(0);
        } else {
            
            resolve(result); //result contains an array of json objects
        }
    });

});

}

//--------------------------------------------------- offerDetails------------------------------------------------------//


app.use("/offerDetails", function (req, res, next) { 
    var taskID = req.body.taskID;
  //  console.log(taskID);

    offerDetailsFunction(taskID).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get all_task_data",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: {
                    "offer_details": result
                },
                msg: ""
            });
    
    
        }
    
    });

});


async function offerDetailsFunction(taskID) {

    let sqlQuery = "SELECT * FROM offer WHERE Task_ID = '" + taskID + "'"
 
    //console.log(sqlQuery);
 
  return new Promise((resolve, reject) => {
 
     pool.query(sqlQuery, (err, result) => {
         if (err) {
             reject("Error executing the query: " + JSON.stringify(err));
             resolve(0);
         } else {
             
             resolve(result); //result contains an array of json objects
         }
     });
 
 });
 
 }
 
//--------------------------------------------------- detailsTakenBy------------------------------------------------------//
app.use("/detailsTakenBy", function (req, res, next) { 

    var taskID = req.body.taskID;
    var workerID = req.body.workerID;

    detailsTakenByFunction(taskID, workerID).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get all_task_data",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: {
                    result
                },
                msg: ""
            });
    
    
        }
    
    });

});


async function detailsTakenByFunction(taskID, workerID) {

    let sqlQuery = "UPDATE task SET Taken_By='"+workerID+"' WHERE Task_ID='"+taskID+"'" ;

    return new Promise((resolve, reject) => {
 
        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                
                resolve(result); //result contains an array of json objects
            }
        });
    
    });

}


//--------------------------------------------------- getTaskDataByID------------------------------------------------------//
app.use("/getTaskDataByID", function (req, res, next) { 

    var taskID = req.body.taskID;

    getTaskDataByID(taskID).then(result => {

        if (result == 0) {
            res.status(200).json({
                success: false,
                error: "Failed to get all_task_data",
                data: {},
                msg: ""
            });
        } else {
            res.status(200).json({
                success: true,
                error: "",
                data: result[0],
                msg: ""
            });
    
    
        }
    
    });

});


async function getTaskDataByID(taskID) {

    let sqlQuery = "SELECT * FROM task WHERE Task_ID = '"+taskID+"';" ;

    return new Promise((resolve, reject) => {
 
        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects
            }
        });
    
    });

}


//--------------------------------------------------- deleteTaskDetails ----------------------------------------------------------------//

app.use("/deleteTaskDetails", function (req, res, next) {

//  let sqlQuery = "DELETE FROM task WHERE Task_ID='"+taskID+"'" ;


var taskID = req.body.taskID;

deleteTaskDetails(taskID).then(result => {

    if (result == 0) {
        res.status(200).json({
            success: false,
            error: "Failed to get all_task_data",
            data: {},
            msg: ""
        });
    } else {
        res.status(200).json({
            success: true,
            error: "",
            data: {},
            msg: ""
        });


    }

});


});

async function deleteTaskDetails(taskID) {

    let sqlQuery = "DELETE FROM task WHERE Task_ID='"+taskID+"' " ;

    return new Promise((resolve, reject) => {
 
        pool.query(sqlQuery, (err, result) => {
            if (err) {
                reject("Error executing the query: " + JSON.stringify(err));
                resolve(0);
            } else {
                resolve(result); //result contains an array of json objects
            }
        });
    
    });

}


module.exports = app;