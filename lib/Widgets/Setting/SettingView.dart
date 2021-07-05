import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Widgets/Setting/SettingConstructor.dart';
import 'package:ti_boulot/Widgets/Setting/SettingController.dart';

class SettingView extends StatefulWidget {
  // final String userID;

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  SettingController settingController = new SettingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // settingController.getAvatar(callSetState);
    int _user;
    Random random = new Random();
    String value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 110.0),
          child: Text(
            'Setting',
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushNamed(context, '/Home'), // returns to previous page
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        child: CircleAvatar(
                          //taking random pictures from the avatar list and assigning to users
                          backgroundImage:
                              ExactAssetImage("${Common.avatarPath}"),
                          minRadius: 35,
                          maxRadius: 35,
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Text('active')
                    ],
                  ), //avatar column
                  SizedBox(
                    width: 54,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Change my avatar',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        children: [
                          DropdownButton(
                            menuMaxHeight: 400.0,
                            hint: new Text('Choose your avatar'),
                            value: _user == null ? null : Common.avatars[_user],
                            items: Common.avatars.map((value) {
                              return new DropdownMenuItem(
                                value: "images/avatars/$value",
                                child: CircleAvatar(
                                  //taking random pictures from the avatar list and assigning to users
                                  backgroundImage:
                                      ExactAssetImage("images/avatars/$value"),
                                  minRadius: 38,
                                  maxRadius: 38,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              Common.avatarPath = value;

                              setState(() {
                                _user = Common.avatars.indexOf(value);
                              });

                              print(value);
                            },

                            // items: settingController.dropdownList,
                            // value: "images/avatars/${Common.avatarPath}",
                            // onChanged: (value) {
                            //   setState(() {});
                            // },
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Colors.deepPurple,
                                size: 30,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: ElevatedButton(
                child: new Text(
                  'PROFILE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepPurple),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    shadowColor: Colors.white.withOpacity(0.1),
                    primary: Colors.grey[400].withOpacity(0.4)),
                onPressed: () async {
                  //some work

                  UserProfileDetail userProfileDetail =
                      await settingController.displayProfile();

                  String userRatingDisplay = userProfileDetail.rating == "null"
                      ? "0"
                      : userProfileDetail.rating;

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'My Profile',
                            style: TextStyle(
                                fontSize: 23.0, color: Color(0xFF673ab7)),
                          ),
                          content: Container(
                            height: 320.0,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Firstname',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ), //Description-text
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    userProfileDetail.firstName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 16.0),
                                  ), //Description-database
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Lastname',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ), //Budget-Text
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(userProfileDetail
                                      .lastName), //Budget-Database

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    'Email',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ), //date posted-text
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(userProfileDetail
                                      .email), //date posted-database

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    'Address',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ), //Deadline text
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(userProfileDetail
                                      .address), //Deadline database

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  Text(
                                    'Rating',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ), //Deadline text
                                  SizedBox(
                                    height: 8.0,
                                  ),

                                  Text("$userRatingDisplay" +
                                      " " +
                                      "out of 5 Stars"), //Address
                                ],
                              ),
                            ),
                          ),
                          backgroundColor:
                              Color(0xFFE7E7E7), //light grey colour
                        );
                      });
                },
              ),
            ),
            SizedBox(
              height: 158.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: ElevatedButton(
                child: new Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepPurple),
                ),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    shadowColor: Colors.white.withOpacity(0.1),
                    primary: Colors.grey[400].withOpacity(0.4)),
                onPressed: () => {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('LOGOUT'),
                      content: const Text('Are you sure you want to logout ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.pushNamed(context, '/Login');
                          }),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
