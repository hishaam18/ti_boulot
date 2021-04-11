import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
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

  Future<void> login(
      String emailAddress, String password, BuildContext context) async {
    var body = {
      "emailAddress": emailAddress.toLowerCase(),
      "password": password
    };

    ResponseType response = await API().post(ApiURL.getURL(ApiURL.login), body);

    print(response.success);

    if (response.success == true) {
      print("Login Successful");

      //navigate to page
      Navigator.pushNamed(context, '/Home');
    } else {
      print(response.error); //display error msg

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
        title: Text("My title"),
        content: Text("Error this Account does not exist"),
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
