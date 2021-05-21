import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/Login/LoginController.dart';
import 'package:validators/validators.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

var email;
var password;

class _LoginViewState extends State<LoginView> {
  LoginController loginController =
      new LoginController(); //creating object to connect to loginController class

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
      body: GestureDetector(
        //gesture detector makes the whole screen clickable
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Container(
              child: SingleChildScrollView(
            child: Form(
              key: loginController.loginKey, //login key
              child: Column(
                children: [
                  Image.asset('images/undraw_Designer_by46.png'),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: loginController.emailController,
                      validator: (email) {
                        if (email.isEmpty) {
                          return "Email address cannot be empty!";
                        } else if (!isEmail(email)) {
                          return "Email address is not valid!";
                        }

                        return null;
                      },
                      // onSaved: (email) => email = email,
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
                      // onChanged: (value) {
                      //   email = value;
                      // },
                    ),
                  ), //email//email
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: loginController.passwordController,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(password))
                          return 'Must contain at least 1 letter, 1 number and 6 characters';

                        return null;
                      },

                      // onSaved: (password) => password = password,
                      obscureText: loginController.obscureTextCheck,
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
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                loginController.obscureTextCheck =
                                    !loginController.obscureTextCheck;
                                loginController.obscureTextIcon =
                                    loginController.obscureTextCheck
                                        ? Icon(
                                            Icons.visibility,
                                            color: Color(0xFF6714b3),
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Color(0xFF6714b3),
                                          );
                              });
                            },
                            child: loginController.obscureTextIcon,
                          ),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      // onChanged: (value) {
                      //   password = value;
                      // },
                    ),
                  ), //password

                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());

                      //*********************************** to remove below 2 lines **********************************
                      loginController.emailController.text =
                          "hishaam@gmail.com";
                      loginController.passwordController.text = "hishaam1234";
                      //********************************** to remove above 2 lines ***********************************

                      if (loginController.loginKey.currentState.validate()) {
                        loginController.login(
                            loginController.emailController.text,
                            loginController.passwordController.text,
                            context);
                      }
                    },
                    child: Card(
                      color: Colors.white60,
                      margin: EdgeInsets.symmetric(
                          horizontal: 75.0, vertical: 20.0),
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
            ),
          )),
        ),
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
