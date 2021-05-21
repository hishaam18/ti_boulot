import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';

class TaskWidget extends StatefulWidget {
  BrowseControllerConstructor data;
  TaskWidget({this.data});
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  String address; //contains converted lat lng to address

  //converts lat lng to address and stores in variable 'address'
  Future<void> loadAddress() async {
    String rawAddress = await API().getAddress(
        ApiURL.reverseGeocodingURL, widget.data.lat, widget.data.lng);
    address = rawAddress;
  }

  @override
  Widget build(BuildContext context) {
//hereeeeee

    loadAddress();

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
                                  return AlertDialog(
                                    title: Text(
                                      widget.data.title,
                                      style: TextStyle(
                                          fontSize: 23.0,
                                          color: Color(0xFF673ab7)),
                                    ),
                                    content: Container(
                                      height: 320.0,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //Budget-Text
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text('Rs ' +
                                                widget.data.budget
                                                    .toString()), //Budget-Database

                                            SizedBox(
                                              height: 20.0,
                                            ),

                                            Text(
                                              'Date Posted',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //date posted-text
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(widget.data.datePosted
                                                .toString()), //date posted-database

                                            SizedBox(
                                              height: 20.0,
                                            ),

                                            Text(
                                              'Task Deadline Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //Deadline text
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(widget.data.dateDeadline
                                                .toString()), //Deadline database

                                            SizedBox(
                                              height: 20.0,
                                            ),

                                            Text(
                                              'Address',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //Deadline text
                                            SizedBox(
                                              height: 8.0,
                                            ),

                                            Text(address), //Address
                                          ],
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        Color(0xFFE7E7E7), //light grey colour
                                  );
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
