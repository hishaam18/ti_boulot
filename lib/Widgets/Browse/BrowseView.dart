import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseController.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';
import 'package:ti_boulot/Widgets/Browse/TaskWidget/TaskWidget.dart';

class BrowseView extends StatefulWidget {
  @override
  _BrowseViewState createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  BrowseController browseController = new BrowseController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  loadTasks() async {
    List<Widget> columnWidgets = await browseController
        .retrieveTask(); //waits for retrieveTask() function to get all tasks from database

    setState(() {
      browseController.bodyContent = Scrollbar(
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
          IconButton(
              onPressed: () {
                setState(() {
                  browseController.bodyContent = SpinKitRotatingCircle(
                    color: Colors.black,
                    size: 50.0,
                  );
                });

                loadTasks();
              },
              icon: Icon(Icons.refresh))
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
        child: browseController
            .bodyContent, //body loads and displays all tasks obtained from retrieveTask() function in BrowseController.dart
      ),
    );
  }
}
