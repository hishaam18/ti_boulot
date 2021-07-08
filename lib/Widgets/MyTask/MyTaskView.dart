import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskController.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskControllerConstructor.dart';

class MyTaskView extends StatefulWidget {
  @override
  _MyTaskViewState createState() => _MyTaskViewState();
}

class _MyTaskViewState extends State<MyTaskView> {
  //creating instance of class myTaskController
  myTaskController MytaskController = myTaskController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingTasks();
  }

  loadingTasks() async {
    List<Widget> columnWidgets = await MytaskController
        .getMyTasks(); //waits for getMyTasks() function to get all tasks from database

    setState(() {
      MytaskController.bodyContent = Scrollbar(
        thickness: 5.0,
        radius: Radius.circular(25.0),
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            children: columnWidgets,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //refresh button
          IconButton(
              onPressed: () {
                setState(() {
                  MytaskController.bodyContent = SpinKitRotatingCircle(
                    color: Colors.black,
                    size: 50.0,
                  );
                });

                loadingTasks();
              },
              icon: Icon(Icons.refresh)) //refresh button
        ],
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 107.0),
          child: Text(
            'My Task',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: Container(),
      ),
      body: Container(
        child: MytaskController
            .bodyContent, //body loads and displays all tasks obtained from retrieveTask() function in BrowseController.dart
      ),
    );
  }
}
