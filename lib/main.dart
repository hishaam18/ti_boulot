import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseController.dart';
import 'package:ti_boulot/Widgets/Home/HomeView.dart';
import 'package:ti_boulot/Widgets/Login/LoginView.dart';
import 'package:ti_boulot/Widgets/SignUp/SignUpView.dart';
import 'Widgets/Choose_Account/ChooseAccountView.dart';
import 'Widgets/PostTask/PostTaskView.dart';
import 'Widgets/Home/HomeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BrowseController controller = new BrowseController();

  @override
  Widget build(BuildContext context) {
    controller.retrieveTask();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //linking the different pages
      initialRoute: '/GetStarted',
      routes: {
        '/GetStarted': (context) => GetStarted(),
        '/Login': (context) => LoginView(),
        '/Choose_Account': (context) => ChooseAccountView(),
        '/SignUp': (context) => SignUpView(),
        '/PostTask': (context) => PostTaskView(),
        '/Home': (context) => HomeView(),
      },
    );
  }
}

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TI BOULOT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  // height: 400.0,
                  child: Image.asset('images/undraw_coffee_break_h3uu (1).png'),
                ),
                SizedBox(
                  height: 85.0,
                ),

                //pushing from main page to Login Pa
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/Choose_Account'); //allow back
                    // Navigator.pushReplacementNamed(context, '/Login'); //NOT allow back
                  },
                  child: Card(
                    color: Colors.white70,
                    margin:
                        EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 40.0,
                        color: Colors.deepPurple,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.deepPurple,
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
