import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';

import 'package:ti_boulot/Widgets/Browse/BrowseController.dart';
import 'PostTaskController.dart';

class PostTaskView extends StatefulWidget {
  @override
  _PostTaskViewState createState() => _PostTaskViewState();
}

class _PostTaskViewState extends State<PostTaskView> {
  PostTaskViewController postTaskViewController =
      new PostTaskViewController(); //object to connect PostTaskView and PostTaskController

  //availability date variables
  DateTime selectedDate = DateTime.now();
  bool dateChosenCheck = false;

  //deadline date variables
  DateTime selectedDateSecond = DateTime.now();
  bool dateChosenCheckSecond = false;

  //stepper navigation variables
  int currentStep = 0;
  bool complete = false;

  //move to next step
  next() {
    if (currentStep == 0) {
      print(postTaskViewController.droppedPinLocation.latitude.toString() +
          ", " +
          postTaskViewController.droppedPinLocation.longitude.toString());

      API().getAddress(
          ApiURL.reverseGeocodingURL,
          postTaskViewController.droppedPinLocation.latitude,
          postTaskViewController.droppedPinLocation.longitude);
    }

    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  //cancels current step
  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  //go to next step
  goTo(int step) {
    setState(() => currentStep = step);
  }

  //switch stepper type
  StepperType stepperType = StepperType.horizontal;

  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  API objectAPI =
      new API(); //creating an object for class API ie an instance of the class

  @override
  Widget build(BuildContext context) {
    objectAPI.getAddress(
        'postTask', -20.5, 53.5); //calling an instance of this function

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 98.0),
          child: Text(
            'Post Task',
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
      body: Theme(
        data: ThemeData(
          accentColor: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          primarySwatch: Colors.deepPurple,
        ),
        child: Form(
          key: postTaskViewController.PostTaskKey,
          child: Column(
            children: [
              complete
                  ? Expanded(
                      child: Center(
                        child: AlertDialog(
                          title: new Text(" Confirm "),
                          content: new Text(
                            "Successfully posted ",
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Post"),
                              onPressed: () {
                                setState(() => complete = false);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Stepper(
                        steps: [
                          Step(
                            title: const Text('Post a Task'),
                            isActive: true,
                            state: StepState.complete,
                            content: Column(
                              children: [
                                SizedBox(height: 20.0),
                                TextFormField(
                                  maxLines: 2,
                                  controller: postTaskViewController
                                      .taskTitleController,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'StemRegular',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 50.0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                    ),
                                    helperText: 'Max 10 Words',
                                    helperStyle: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    labelText: 'Task Title ',
                                    labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    hintText: 'E.g  Paint 3 rooms',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ), //task-title
                                SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: postTaskViewController
                                      .taskDescriptionController,
                                  maxLines: 10,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'StemRegular',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 50.0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                    ),
                                    labelText: 'Task Description',
                                    labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    hintText:
                                        'E.g. There are 3 rooms of 50m2 each.',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ), //task-description
                                SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Please Choose the location of the task in the map',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'StemRegular',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(postTaskViewController
                                          .displayAddress),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2.0,
                                              color: Colors.grey[400]),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: new FlutterMap(
                                          options: new MapOptions(
                                              onTap: (droppedPin) {
                                                setState(() {
                                                  postTaskViewController
                                                      .dropPin(
                                                          droppedPin.latitude,
                                                          droppedPin.longitude);

                                                  postTaskViewController
                                                          .displayAddress =
                                                      objectAPI.fullAddress ??
                                                          'loading';
                                                });
                                              },
                                              center: latLng.LatLng(
                                                  -20.1609, 57.5012),
                                              zoom: 11.0,
                                              maxZoom: 18.2),
                                          layers: [
                                            new TileLayerOptions(
                                                urlTemplate:
                                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                subdomains: ['a', 'b', 'c']),
                                            new MarkerLayerOptions(
                                              markers: [
                                                postTaskViewController
                                                    .dropPinMarker,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ), //flutterMap + Text_instructions
                                    ],
                                  ),
                                ), //flutterMap
                                SizedBox(
                                  height: 30.0,
                                ),
                                //flutter_map
                              ],
                            ),
                          ), //title/description/location
                          Step(
                            isActive: true,
                            state: StepState.editing,
                            title: const Text('Date and Time'),
                            content: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        dateChosenCheck
                                            ? 'Available as from: ' +
                                                postTaskViewController
                                                    .displayDate
                                            : 'Choose Task availability date:',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'StemRegular',
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 50.0,
                                      color: Color(0xFF673ab7),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          final DateTime picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                selectedDateSecond, // Refer step 1
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(
                                                DateTime.now().year.toInt() +
                                                    3),
                                          );
                                          if (picked != null &&
                                              picked != selectedDateSecond)
                                            setState(() {
                                              dateChosenCheck = true;
                                              selectedDateSecond = picked;

                                              postTaskViewController
                                                      .displayDate =
                                                  convertDateToReadable(
                                                      selectedDateSecond
                                                          .toString());
                                            });
                                        },
                                        child: Icon(Icons.calendar_today),
                                      ),
                                    )
                                  ],
                                ), //date as from
                                SizedBox(height: 30.0),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        dateChosenCheckSecond
                                            ? 'Task Deadline: ' +
                                                postTaskViewController
                                                    .displayDeadlineDate
                                            : 'Choose Task Deadline date:',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'StemRegular',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Container(
                                      height: 50.0,
                                      color: Color(0xFF673ab7),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          final DateTime picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                selectedDateSecond, // Refer step 1
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(
                                                DateTime.now().year.toInt() +
                                                    3),
                                          );
                                          if (picked != null &&
                                              picked != selectedDateSecond)
                                            setState(() {
                                              dateChosenCheckSecond = true;
                                              selectedDateSecond = picked;

                                              postTaskViewController
                                                      .displayDeadlineDate =
                                                  convertDateToReadable(
                                                      selectedDateSecond
                                                          .toString());
                                            });
                                        },
                                        child: Icon(Icons.calendar_today),
                                      ),
                                    ),
                                    SizedBox(height: 30.0),
                                  ],
                                ), //date deadline
                              ],
                            ),
                          ), //date
                          Step(
                            isActive: true,
                            state: StepState.editing,
                            title: const Text('Budget'),
                            content: Column(
                              children: <Widget>[
                                TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('([0-9]+(\.[0-9]+)?)')),
                                  ],
                                  controller:
                                      postTaskViewController.budgetController,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'StemRegular',
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 50.0),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                    ),
                                    helperText: 'Numbers only',
                                    helperStyle: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    labelText: 'Budget (Rs)',
                                    labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'StemRegular',
                                    ),
                                    hintText: 'E.g 1000',
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  child: Text('Submit'),
                                  color: Colors.blueAccent,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    //on pressing this button, sending each input of the text fields, as an object, to the controller
                                    postTaskViewController.postTask(
                                      postTaskViewController
                                          .taskTitleController.text,
                                      postTaskViewController
                                          .taskDescriptionController.text,
                                      postTaskViewController.lat,
                                      postTaskViewController.lng,
                                      postTaskViewController
                                          .budgetController.text,
                                      postTaskViewController.displayDate,
                                      postTaskViewController
                                          .displayDeadlineDate,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                        type: stepperType,
                        currentStep: currentStep,
                        onStepContinue: next,
                        onStepTapped: (step) => goTo(step),
                        onStepCancel: cancel,
                      ),
                    ),
            ],
          ),
        ),
      ),

      //floating action button which activates switch step
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.list),
        onPressed: switchStepType,
      ),
    );
  } //BuildContext

  String convertDateToReadable(String date) {
    return date.split(" ")[0].split("-")[2] +
        "-" +
        date.split(" ")[0].split("-")[1] +
        "-" +
        date.split(" ")[0].split("-")[0];
  }
}
