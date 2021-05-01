import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';
import 'package:ti_boulot/Widgets/Browse/TaskWidget/TaskWidget.dart';

/*  *****************    Getting PostTask values from Backend    ********************   */

class BrowseController {
  List<Widget> tasks = new List<Widget>();

  Widget bodyContent = SpinKitRotatingCircle(
    color: Colors.black,
    size: 50.0,
  );

  Future<List<Widget>> retrieveTask() async {
    var body = {};

    //getting response from backend from: (app.use/login)
    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.retrieveTask), body);

    //response contains all data from task table
    if (response.success) {
      List<Widget> columnWidgets = new List<Widget>();

      columnWidgets.clear();
      columnWidgets.add(SizedBox(
        height: 20.0,
      ));

      for (var task in response.data['task_data']) {
        columnWidgets.add(TaskWidget(
          data: BrowseControllerConstructor.fromJson(task),
        ));
      }

      columnWidgets.add(SizedBox(
        height: 100.0,
      ));

      return columnWidgets;
    } else {
      //use alert box --> display response.error
    }
  }
}
