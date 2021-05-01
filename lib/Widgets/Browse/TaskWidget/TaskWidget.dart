import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';

class TaskWidget extends StatefulWidget {
  BrowseControllerConstructor data;

  TaskWidget({this.data});

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("Aahhhhhh");
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: Color(0xFF673ab7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            widget.data.taskDescription,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
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
                            print(widget.data.title + " is fucked");
                          },
                          icon: Icon(
                            Icons.open_in_new,
                            size: 32.0,
                            color: Color(0xFF673ab7),
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
