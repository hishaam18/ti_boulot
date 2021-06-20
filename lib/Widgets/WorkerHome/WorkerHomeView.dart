import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/Message/MessageView.dart';
import 'package:ti_boulot/Widgets/MyTask/MyTaskView.dart';
import 'package:ti_boulot/Widgets/Notifications/Notifications.dart';
import 'package:ti_boulot/Widgets/Setting/SettingView.dart';
import 'package:ti_boulot/Widgets/WorkerBrowse/WorkerBrowseView.dart';

class WorkerHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WorkerHomeView(title: 'Flutter Convex Bottom Bar'),
    );
  }
}

class WorkerHomeView extends StatefulWidget {
  WorkerHomeView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WorkerHomeViewState createState() => _WorkerHomeViewState();
}

class _WorkerHomeViewState extends State<WorkerHomeView> {
  int selectedPage = 2; //int with default 0

  final _pageOptions = [
    MessageView(),
    NotificationsView(),
    WorkerBrowseView(),
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
          //Whatever is written under the Icons
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.notifications, title: 'Notifications'),
          TabItem(icon: Icons.add_circle_outline, title: 'Browse'),
          TabItem(icon: Icons.inventory, title: 'MyTasks'),
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
