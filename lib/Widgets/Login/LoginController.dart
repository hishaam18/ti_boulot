import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class LoginController {
  final loginKey = GlobalKey<FormState>();
  bool obscureTextCheck = true;

  Widget obscureTextIcon = Icon(
    Icons.visibility,
    color: Colors.black,
  );

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  //future used to represent values that will be available later ie,
  //once callback functions receive their values
  Future<void> login(
      String emailAddress, String password, BuildContext context) async {
    var body = {
      "emailAddress": emailAddress.toLowerCase(),
      "password": password
    };

    //getting response from backend from: (app.use/login)
    ResponseType response = await API().post(ApiURL.getURL(ApiURL.login), body);
    print(response.data);
    //print response
    // print(response.success);

    if (response.success == true && response.data['User_Type'] == 'Worker') {
      print(response.data['User_Type']);
      Common.userID = response.data['User_ID'].toString();
      Common.avatarPath = "images/avatars/" + response.data['Avatar_Path'];
      Common.userType = response.data['User_Type'].toString();

      print(response.data['User_Type']);
      //storing User_ID of User received from backend response, into static
      //variable ' User_ID ' found in common

      //navigate to User Home page
      Navigator.pushReplacementNamed(
          context, '/WorkerHomeView'); //NOT allow back

    }

    //Load User Home page if login is User
    else if (response.success == true && response.data['User_Type'] == 'User') {
      //storing User_ID of User received from backend response, into static
      //variable ' User_ID ' found in common
      // print(response.data['User_ID']);
      Common.userID = response.data['User_ID'].toString();
      Common.avatarPath = "images/avatars/" + response.data['Avatar_Path'];
      Common.userType = response.data['User_Type'].toString();
      // Common.avatarPath = response.data['Avatar_Path'];

      print(response.data['User_Type']);

      // if (response.data['User_Type'] == 'Worker') {
      //   //open worker page
      // } else {
      //   //open user page
      // }

      //navigate to User Home page
      Navigator.pushReplacementNamed(context, '/Home'); //NOT allow back

    }

    //Load Worker Home page if login is User
    else {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Error"),
        content: Text("Invalid Email or Password"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
