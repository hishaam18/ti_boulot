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
      print("Hurray!");
      //navigate to page

    } else {
      print(response.error); //display error msg

    }
  }
}
