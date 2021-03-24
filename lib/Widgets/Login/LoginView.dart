import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/CustomTextField.dart';
import 'package:ti_boulot/Widgets/Login/LoginController.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController =
      new LoginController(); //creating n object to connect to loginController class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 113.0),
          child: Text(
            'Login',
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
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              // Text(
              //   'Login',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 25.0,
              //     color: Colors.deepPurple,
              //   ),
              // ),

              Image.asset('images/undraw_Designer_by46.png'),
              BeautyTextfield(
                width: double.infinity,
                height: 60.0,
                backgroundColor: Colors.deepPurple,
                iconColor: Colors.white,
                prefixIcon: Icon(Icons.email),
                inputType: TextInputType.text,
                textColor: Colors.white,
                placeholder: 'Email',
              ),
              BeautyTextfield(
                width: double.infinity,
                height: 60.0,
                backgroundColor: Colors.deepPurple,
                iconColor: Colors.white,
                prefixIcon: Icon(Icons.lock),
                inputType: TextInputType.text,
                textColor: Colors.white,
                placeholder: 'Password',
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/Login'); //allow back
                  // Navigator.pushReplacementNamed(context, '/Login'); //NOT allow back
                },
                child: Card(
                  color: Colors.white60,
                  margin:
                      EdgeInsets.symmetric(horizontal: 75.0, vertical: 20.0),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 80.0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: " Don't have an account ?  ",
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    new TextSpan(
                      text: 'Sign Up',
                      style: new TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/SignUp');
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
//   backgroundColor: Colors.deepPurple,
//   child: Icon(Icons.add),
//   onPressed: () {
//     setState(() {
//       loginController.listWidget.add(loginController.getWidget());
//       loginController.count++;
//     });
//   },
// ),

// bottomNavigationBar: ConvexAppBar(
//   style: TabStyle.react,
//   curve: Curves.easeInQuad,
//   backgroundColor: Colors.deepPurple,
//   items: [
//     TabItem(icon: Icons.home, title: 'Home'),
//     TabItem(icon: Icons.map, title: 'Discovery'),
//     TabItem(icon: Icons.add, title: 'Add'),
//     TabItem(icon: Icons.message, title: 'Message'),
//     TabItem(icon: Icons.people, title: 'Profile'),
//   ],
//   initialActiveIndex: 2, //optional, default as 0
//   onTap: (int i) => print('click index=$i'),
// ),

//Checking git
