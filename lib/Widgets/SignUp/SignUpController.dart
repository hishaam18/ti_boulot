import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupController {
  final signUpKey = GlobalKey<FormState>();
  String selectedType;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  void signUp(String firstName, lastName, emailAddress, location, password,
      occupation, experience) {
    occupation = "";
    experience = "";

    //json format obj
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "emailAddress": emailAddress,
      "location": location,
      "password": password,
      "accountType": selectedType,
      "occupation": occupation,
      "experience": experience,
    };

    var response = postReq(body);

    print(response);
  }

  Future<dynamic> postReq(var body) async {
    var response =
        //   await http.post('http://localhost:9000/register', body: body);
        await http.post('http://10.0.2.2:9000/register',
            body: body); // localhost has been replaced by 10.0.2.2 to be
    return response;
  }
}
