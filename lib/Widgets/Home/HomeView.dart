import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/Message/MessageView.dart';
import 'package:ti_boulot/Widgets/MyTask/MyTaskView.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseView.dart';
import 'package:ti_boulot/Widgets/Setting/SettingView.dart';

//contains navigation bar to all the other 5 pages
class HomeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(title: 'Flutter Convex Bottom Bar'),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeView> {
  int selectedPage = 1; //int with default 0

  final _pageOptions = [
    MessageView(),
    BrowseView(),
    MyTaskView(),
    SettingView(),
  ]; //5 pages stored in array form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        curve: Curves.easeInQuad,
        backgroundColor: Colors.deepPurple,
        items: [
          //bottom av bar routes
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.add_circle_outline, title: 'Browse'),
          TabItem(icon: Icons.inventory, title: 'MyTask'),
          TabItem(icon: Icons.settings, title: 'Setting'),
        ],

        initialActiveIndex: 2, //optional, default as 0

        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),

          //onPressed -> floating action button
          onPressed: () {
            Navigator.pushNamed(context, '/PostTask');
          },
        ),
      ),
    );
  }
}
