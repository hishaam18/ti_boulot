import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ti_boulot/Common/CustomTextField.dart';
import 'package:ti_boulot/Widgets/SignUp/SignUpController.dart';
import 'package:validators/validators.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

var firstname;
var lastname;
var email;
var location;
var password;
var confirmpassword;
var accounttype;

class _SignUpViewState extends State<SignUpView> {
  SignupController signupController = new SignupController();

  @override
  Widget build(BuildContext context) {
    List listItem = [
      "Worker",
      "Customer",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false), // returns to previous page
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Container(
              child: SingleChildScrollView(
            child: Form(
              key: signupController.signUpKey,
              child: Column(
                children: [
                  SizedBox(height: 25.0),
                  SvgPicture.asset(
                    'images/undraw_adventure_map_hnin.svg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.firstNameController,
                      validator: (firstName) {
                        if (firstName.isEmpty) {
                          return "First name cannot be empty!";
                        } else if (!isAlpha(firstName)) {
                          return "First name should contain only letters";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.person),
                        ),
                        labelText: 'Firstname',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        firstname = value;
                      },
                    ),
                  ), //firstname
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.lastNameController,
                      validator: (lastName) {
                        if (lastName.isEmpty) {
                          return "Last name cannot be empty!";
                        } else if (!isAlpha(lastName)) {
                          return "Last name should contain only letters";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.person),
                        ),
                        labelText: 'Lastname',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        lastname = value;
                      },
                    ),
                  ), //lastname
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.emailController,
                      validator: (email) => EmailValidator.validate(email)
                          ? null
                          : "Invalid email address",
                      onSaved: (email) => email = email,
                      // validator: (emailAddress) {
                      //   if (emailAddress.isEmpty) {
                      //     return "Email Address cannot be empty!";
                      //   }
                      //   return null;
                      // },
                      //
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.email),
                        ),
                        labelText: 'Email address',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ), //email
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.locationController,
                      validator: (location) {
                        if (location.isEmpty) {
                          return "Location cannot be empty!";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.add_location_alt),
                        ),
                        labelText: 'Location',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        location = value;
                      },
                    ),
                  ), //location
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.passwordController,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(password))
                          return 'Must contain at least 1 letter, 1 number and 6 characters';
                        else
                          return null;
                      },
                      onSaved: (password) => password = password,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.lock),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ), //password
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: signupController.confirmPasswordController,
                      validator: (ConfirmPassword) {
                        if (ConfirmPassword.isEmpty) {
                          return "Please fill in the confirm password field!";
                        }
                        if (ConfirmPassword != password) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 50.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(Icons.lock),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        confirmpassword = value;
                      },
                    ),
                  ), //confirm password
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: DropdownButton(
                      hint: Text("Account type: "),
                      value: signupController.selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          signupController.selectedType = newValue;
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: signupController.selectedType == "Worker"
                        ? Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller:
                                      signupController.occupationController,
                                  validator: (occupation) {
                                    if (occupation.isEmpty) {
                                      return "Occupation cannot be empty!";
                                    } else if (!isAlpha(occupation)) {
                                      return "Occupation should contain only letters";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'StemRegular',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 50.0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Icon(Icons.person),
                                    ),
                                    labelText: 'Occupation',
                                    labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    firstname = value;
                                  },
                                ),
                              ), //firstname
                              SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller:
                                      signupController.experienceController,
                                  validator: (experience) {
                                    if (experience.isEmpty) {
                                      return "Occupation cannot be empty!";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'StemRegular',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 50.0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Icon(Icons.person),
                                    ),
                                    labelText: 'Worker experience (in years)',
                                    labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    lastname = value;
                                  },
                                ),
                              ), //l/l
                            ],
                          )
                        : null,
                  ), //Dropdown menu: worker, customer
                  InkWell(
                    onTap: () {
                      // FocusScope.of(context).requestFocus(new FocusNode());

                      if (signupController.signUpKey.currentState.validate()) {
                        // sign up method
                        signupController.signUp(
                          signupController.firstNameController.text,
                          signupController.lastNameController.text,
                          signupController.emailController.text,
                          signupController.locationController.text,
                          signupController.passwordController.text,
                          signupController.occupationController.text,
                          signupController.experienceController.text,
                        );
                      }

                      // Navigator.pushNamed(context, '/Login'); //allow back
                      // Navigator.pushReplacementNamed(context, '/Login'); //NOT allow back
                    },
                    child: Card(
                      color: Colors.white60,
                      margin: EdgeInsets.symmetric(
                          horizontal: 75.0, vertical: 20.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 80.0),
                          child: Text(
                            'Sign Up',
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
                          text: " Already have an account ?  ",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        new TextSpan(
                          text: 'Sign In',
                          style: new TextStyle(
                            color: Colors.blue,
                            fontSize: 18.0,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/Login');
                            },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
