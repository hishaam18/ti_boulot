import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/CustomTextField.dart';
import 'package:ti_boulot/Widgets/Login/LoginController.dart';

class ChooseAccountView extends StatefulWidget {
  @override
  _ChooseAccountViewState createState() => _ChooseAccountViewState();
}

class _ChooseAccountViewState extends State<ChooseAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        // title: Text(
        //   'Back',
        //   style: TextStyle(color: Colors.white),
        // ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false), // returns to previous page
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: 400.0,
                  child: Image.asset('images/undraw_add_tasks_mxew (1).png'),
                ),
                //pushing from main page to Login Pa
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/Login'); //allow back
                    // Navigator.pushReplacementNamed(context, '/Login'); //NOT allow back
                  },
                  child: Card(
                    color: Colors.white70,
                    margin:
                        EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.login,
                        size: 40.0,
                        color: Colors.deepPurple,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/SignUp'); //allow back
                    // Navigator.pushReplacementNamed(context, '/Login'); //NOT allow back
                  },
                  child: Card(
                    color: Colors.deepPurple,
                    margin:
                        EdgeInsets.symmetric(horizontal: 75.0, vertical: 0.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.assignment_ind,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
