import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Widgets/MyTask/Content/ContentMyTaskView.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskControllerConstructor.dart';

class myTaskController {
  List<Widget> tasks =
      new List<Widget>(); //creating iterable/growing list (like arraylist)

  Widget bodyContent = SpinKitRotatingCircle(
    color: Colors.black,
    size: 50.0,
  ); //loading circle

  //Function to get all tasks from backend
  Future<List<Widget>> getMyTasks(Function loadData) async {
    var body = {
      "User_ID": Common.userID,
    };

    //getting response from backend from: (app.use/login)
    //Note: ResponseType (see Common) is an obj with has format to receive response from backend
    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.getMyTasks), body);

    //response contains all data from task table
    if (response.success) {
      List<Widget> columnWidgets = new List<Widget>();

      columnWidgets.clear();
      columnWidgets.add(SizedBox(
        height: 20.0,
      ));

      //For-loop
      for (int i = 0; i < response.data['mytask_data'].length; i++) {
        //getting information from backend retrieveTask(), response.data is the data field from the http response and its called task_data
        //task_data contains all
        columnWidgets.add(ContentMyTaskView(
          loadData: loadData,
          data: myTaskControllerConstructor().fromJson(response
                  .data['mytask_data'][
              i]), //displaying task_data from json format to normal (see TaskWidget.dart)
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
