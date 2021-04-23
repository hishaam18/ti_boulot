import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import "package:latlong/latlong.dart" as latLng;

class PostTaskViewController {
  final PostTaskKey = GlobalKey<FormState>();

  TextEditingController taskTitleController = new TextEditingController();
  TextEditingController taskDescriptionController = new TextEditingController();

  TextEditingController taskLocationController = new TextEditingController();

  TextEditingController budgetController = new TextEditingController();
  String displayDate; //availability
  String displayDeadlineDate; //dealine

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

  Future<void> postTask(String title, description, location, displayDate,
      displayDeadlineDate, budget) async {
    var body = {
      "title": title,
      "description": description,
      "location": location,
      "budget": budget,
      "displayDate": displayDate,
      "displayDeadlineDate": displayDeadlineDate,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.postTask), body);

    print(response);
  }
}
