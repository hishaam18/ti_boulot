import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskControllerConstructor.dart';

class ContentMyTaskView extends StatefulWidget {
  myTaskControllerConstructor data;
  ContentMyTaskView({this.data});
  @override
  _ContentMyTaskViewState createState() => _ContentMyTaskViewState();
}

class _ContentMyTaskViewState extends State<ContentMyTaskView> {
  String convertAddress;
  // used in slider

  //function to convert lat lng to address and stores in variable 'loadConvertedAddress'
  Future<void> loadConvertedAddress() async {
    String rawAddress = await API().getAddress(
        ApiURL.reverseGeocodingURL, widget.data.lat, widget.data.lng);
    convertAddress = rawAddress;
  }

  @override
  Widget build(BuildContext context) {
    loadConvertedAddress();

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("Gesture Detector");
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: Color(0xFFE7E7E7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF673ab7),
                                fontSize: 19.0,
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              widget.data.taskDescription,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 60.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white,
                      ),
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return popUpView(
                                      data: widget.data,
                                      address: convertAddress);
                                });
                          },
                          icon: Icon(
                            Icons.open_in_new,
                            size: 32.0,
                            color: Color(0xFF673ab7), //icon button to pop up
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}

class popUpView extends StatefulWidget {
  final myTaskControllerConstructor data;
  final String address;

  popUpView({this.data, this.address});
  @override
  _popUpViewState createState() => _popUpViewState();
}

class _popUpViewState extends State<popUpView> {
  double myValue = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.data.title,
        style: TextStyle(fontSize: 23.0, color: Color(0xFF673ab7)),
      ),
      content: Container(
        height: 320.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ), //Description-text
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.data.taskDescription,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ), //Description-database
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Budget',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), //Budget-Text
              SizedBox(
                height: 8.0,
              ),
              Text('Rs ' + widget.data.budget.toString()), //Budget-Database

              SizedBox(
                height: 20.0,
              ),

              Text(
                'Date Posted',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), //date posted-text
              SizedBox(
                height: 8.0,
              ),
              Text(widget.data.datePosted.toString()), //date posted-database

              SizedBox(
                height: 20.0,
              ),

              Text(
                'Task Deadline Date',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), //Deadline text
              SizedBox(
                height: 8.0,
              ),
              Text(widget.data.dateDeadline.toString()), //Deadline database

              SizedBox(
                height: 20.0,
              ),

              Text(
                'Address',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ), //Deadline text
              SizedBox(
                height: 8.0,
              ),

              Text(widget.address),
              SizedBox(
                height: 20.0,
              ),

              Text(
                ' Rate: Quality of work (${myValue.toInt().toString()})',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 25.0,
              ),

              Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade500,
                    borderRadius: BorderRadius.circular(10)),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red[700],
                    inactiveTrackColor: Colors.red[100],
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: Colors.redAccent,
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    activeTickMarkColor: Colors.red[700],
                    inactiveTickMarkColor: Colors.red[100],
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.redAccent,
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    value: myValue,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    activeColor: Colors.black,
                    inactiveColor: Colors.white,
                    label: myValue.round().toString(),
                    onChanged: (newValue) {
                      setState(() {
                        myValue = newValue;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 25.0,
              ),

              Row(
                children: [
                  RaisedButton(
                      child: Text(
                        'Completed',
                        style: TextStyle(fontSize: 13),
                      ),
                      color: Colors.deepPurple,
                      textColor: Colors.white70,
                      padding: EdgeInsets.all(5.0),
                      splashColor: Colors.white70,
                      onPressed: () {}),
                  SizedBox(
                    width: 15.0,
                  ),
                  RaisedButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 13),
                      ),
                      color: Colors.red,
                      textColor: Colors.white70,
                      padding: EdgeInsets.all(5.0),
                      splashColor: Colors.white70,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              //Address
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFE7E7E7), //light grey colour
    );
    ;
  }
}
