import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Widgets/WorkerBrowse/WorkerBrowseController.dart';

class WorkerBrowseView extends StatefulWidget {
  @override
  _WorkerBrowseViewState createState() => _WorkerBrowseViewState();
}

class _WorkerBrowseViewState extends State<WorkerBrowseView> {
  WorkerBrowseController workerBrowseController = new WorkerBrowseController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workerLoadTasks();
  }

  workerLoadTasks() async {
    List<Widget> columnWidgets = await workerBrowseController
        .workerRetrieveTask(); //waits for retrieveTask() function to get all tasks from database

    setState(() {
      workerBrowseController.bodyContent = Scrollbar(
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
                  workerBrowseController.bodyContent = SpinKitRotatingCircle(
                    color: Colors.black,
                    size: 50.0,
                  );
                });

                workerLoadTasks();
              },
              icon: Icon(Icons.refresh)) //refresh button
        ],
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 107.0),
          child: Text(
            'Browse',
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
      body: Container(
        child: workerBrowseController
            .bodyContent, //body loads and displays all tasks obtained from retrieveTask() function in BrowseController.dart
      ),
    );
  }
}
