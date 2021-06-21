import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Widgets/Setting/SettingController.dart';

class SettingView extends StatefulWidget {
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
    settingController.getAvatar(callSetState);

    Random random = new Random();

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
              Navigator.pop(context, false), // returns to previous page
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 20,
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
                          backgroundImage: ExactAssetImage(
                              "images/avatars/${Common.avatarPath}"),
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
                            value: "images/avatars/${Common.avatarPath}",
                            items: settingController.dropdownList,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          IconButton(icon: Icon(Icons.save), onPressed: () {})
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 290,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Center(
                  child: RaisedButton(
                color: Colors.deepPurple,
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
                              Future.delayed(Duration(seconds: 1), () {
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
                child: new Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                padding: new EdgeInsets.all(15),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
