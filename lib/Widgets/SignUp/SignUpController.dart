import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class SignupController {
  final signUpKey = GlobalKey<FormState>();
  String selectedType;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController occupationController = new TextEditingController();
  TextEditingController experienceController = new TextEditingController();

  Future<void> signUp(String firstName, lastName, emailAddress, location,
      password, occupation, experience) async {
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

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.register), body);

    print(response);
  }
}
