import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import "package:latlong/latlong.dart" as latLng;

class PostTaskViewController {
  final PostTaskKey = GlobalKey<FormState>();

  TextEditingController taskTitleController = new TextEditingController();
  TextEditingController taskDescriptionController = new TextEditingController();

  // TextEditingController taskLocationController = new TextEditingController();

  String lat;
  String lng;

  TextEditingController budgetController = new TextEditingController();
  String displayDate; //availability - creating a global variable
  String displayDeadlineDate; //dealine- creating a global variable

  //
  Marker dropPinMarker = Marker(
    width: 80.0,
    height: 80.0,
    point: new latLng.LatLng(-20.1609, 57.5012),
    builder: (ctx) => new Container(
      child: IconButton(
        icon: Icon(Icons.location_on),
        iconSize: 45.0,
      ),
    ),
  );

  //Contains latitude and longitude
  latLng.LatLng droppedPinLocation;

  dropPin(double latitude, double longitude) {
    droppedPinLocation = new latLng.LatLng(latitude, longitude);

    //Assigning latitude and longitude values to Global variables: lat and long
    lat = droppedPinLocation.latitude.toString();
    lng = droppedPinLocation.longitude.toString();

    dropPinMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: droppedPinLocation,
      builder: (ctx) => new Container(
        child: IconButton(
          icon: Icon(Icons.location_on),
          iconSize: 45.0,
        ),
      ),
    );
  }

  //Function to send post request to backend ( containing details of post task function)
  Future<void> postTask(String title, task_description, lat, lng, budget,
      displayDate, displayDeadlineDate) async {
    var body = {
      "User_ID": Common.userID,
      "title": title,
      "task_description": task_description,
      "lat": lat,
      "lng": lng,
      "budget": budget,
      "displayDate": displayDate,
      "displayDeadlineDate": displayDeadlineDate,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.postTask), body);

    print(response.data);
  }
}
