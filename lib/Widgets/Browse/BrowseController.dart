import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';
import 'package:ti_boulot/Widgets/Browse/TaskWidget/TaskWidget.dart';

/*  *****************    Getting all tasks data from Backend -- retriveTask() in backend   ********************   */

class BrowseController {
  List<Widget> tasks = new List<Widget>(); //creating an iterable/growing list

  Widget bodyContent = SpinKitRotatingCircle(
    color: Colors.black,
    size: 50.0,
  ); //loading circle

  Future<List<Widget>> retrieveTask() async {
    var body = {};

    //getting response from backend from: (app.use/login)
    //Note: ResponseType (see Common) is an obj with has format to receive response from backend
    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.retrieveTask), body);

    //response contains all data from task table
    if (response.success) {
      List<Widget> columnWidgets = new List<Widget>();

      columnWidgets.clear();
      columnWidgets.add(SizedBox(
        height: 20.0,
      ));

      //For-loop
      for (var task in response.data['task_data']) {
        //getting information from backend retrieveTask(), response.data is the data field from the response and its called task_data
        //task_data contains all
        columnWidgets.add(TaskWidget(
          data: BrowseControllerConstructor.fromJson(
              task), //displaying task_data from json format to normal
        ));
      }

      columnWidgets.add(SizedBox(
        height: 100.0,
      )); //to seperate each task

      return columnWidgets;
    } else {
      AlertDialog(
        title: Text('Error'),
        content: Text('Error cannot get data from database'),
      );
      //use alert box --> display response.error
    }
  }
}
