import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Widgets/Browse/BrowseControllerConstructor.dart';
import 'package:ti_boulot/Widgets/MyTask/Content/ContentMyTaskController.dart';
import 'package:ti_boulot/Widgets/MyTask/Content/offerConstructor.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskController.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskControllerConstructor.dart';

class ContentMyTaskView extends StatefulWidget {
  myTaskControllerConstructor data;
  final Function loadData;
  ContentMyTaskView({this.data, this.loadData});
  @override
  _ContentMyTaskViewState createState() => _ContentMyTaskViewState();
}

class _ContentMyTaskViewState extends State<ContentMyTaskView> {
  ContentMyTaskController contentMyTaskController =
      new ContentMyTaskController();

  String convertAddress;
  // used in slider

  //function to convert lat lng to address and stores in variable 'loadConvertedAddress'
  Future<void> loadConvertedAddress() async {
    // String rawAddress = await API().getAddress(
    //     ApiURL.reverseGeocodingURL, widget.data.lat, widget.data.lng);

    convertAddress = 'Royal Road, Chemin-Grenier';

    // print(widget.data.taskID);
  }

  @override
  Widget build(BuildContext context) {
    loadConvertedAddress();

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // print("Gesture Detector");
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
                          Flexible(
                            child: Text(
                              widget.data.taskDescription,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
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
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return popUpView(
                                      loadData: widget.loadData,
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
  final Function loadData;
  myTaskControllerConstructor data;
  final String address;

  popUpView({this.loadData, this.data, this.address});
  @override
  _popUpViewState createState() => _popUpViewState();
}

class _popUpViewState extends State<popUpView> {
  double myValue = 0;
  ContentMyTaskController contentMyTaskController =
      new ContentMyTaskController();

  bool isVisible = true;

  String dropdownvalue = 'task1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await contentMyTaskController.offerDetails(widget.data.taskID.toString());

    setState(() {});
  }

  refreshData() async {
    widget.data =
        await contentMyTaskController.getTaskDataByID(widget.data.taskID);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.takenBy);

    return Container(
      child: AlertDialog(
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
                //date posted-database
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

                widget.data.takenBy == "null" || widget.data.takenBy == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assign Task',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          DropdownButton(
                            value: contentMyTaskController.selectedValue,
                            hint: Text("Select an offer"),
                            icon: Icon(Icons.expand_more),
                            items: contentMyTaskController.dropdownItems
                                .map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      items,
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                contentMyTaskController.selectedValue =
                                    newValue;
                                dropdownvalue = newValue;
                              });

                              //await assignUserToTask(contentMyTaskController.offerUser[contentMyTaskController.selectedValue]);
                              // print(contentMyTaskController.offerUser[
                              //     contentMyTaskController.selectedValue]);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                              child: Text(
                                'Assign',
                                style: TextStyle(fontSize: 13),
                              ),
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(5.0),
                              splashColor: Colors.white70,
                              onPressed: () async {
                                //sending taskID and user ID to api
                                await contentMyTaskController.detailsTakenBy(
                                    widget.data.taskID.toString(),
                                    contentMyTaskController.offerUser[
                                        contentMyTaskController.selectedValue]);
                                await widget.loadData();
                                await refreshData();
                                setState(() {});

                                //  await detailsTakenBy(contentMyTaskController.offerUser[contentMyTaskController.selectedValue]);
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      )
                    : widget.data.taskRating == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Rate: Quality of work (${myValue.toInt().toString()})',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
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
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 12.0),
                                    thumbColor: Colors.redAccent,
                                    overlayColor: Colors.red.withAlpha(32),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 28.0),
                                    tickMarkShape: RoundSliderTickMarkShape(),
                                    activeTickMarkColor: Colors.red[700],
                                    inactiveTickMarkColor: Colors.red[100],
                                    valueIndicatorShape:
                                        PaddleSliderValueIndicatorShape(),
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
                                height: 20.0,
                              ),
                              RaisedButton(
                                  child: Text(
                                    'Rate',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  color: Colors.deepPurple,
                                  textColor: Colors.white70,
                                  padding: EdgeInsets.all(5.0),
                                  splashColor: Colors.white70,
                                  onPressed: () async {
                                    contentMyTaskController.taskRating(
                                        widget.data.taskID.toString(),
                                        myValue.toString());

                                    contentMyTaskController.allTaskData(
                                        widget.data.taskID.toString());

                                    await widget.loadData();
                                    await refreshData();
                                    setState(() {});

                                    // Future.delayed(const Duration(milliseconds: 400),
                                    //     () {
                                    //   Navigator.pop(context);
                                    // });
                                  }),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task Quality Rating',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('You rated this task ' +
                                  widget.data.taskRating.toString() +
                                  '/5 Stars'),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),

                Row(
                  children: [
                    SizedBox(
                      width: 180.0,
                    ),
                    RaisedButton(
                        child: Text(
                          'Delete this task',
                          style: TextStyle(fontSize: 13),
                        ),
                        color: Colors.red,
                        textColor: Colors.white70,
                        padding: EdgeInsets.all(5.0),
                        splashColor: Colors.white70,
                        onPressed: () {
                          contentMyTaskController
                              .deleteTask(widget.data.taskID.toString());

                          Future.delayed(const Duration(milliseconds: 400), () {
                            Navigator.pop(context);
                          });
                        }),
                  ],
                ),
                SizedBox(
                  width: 8.0,
                ),

                //Address
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFFE7E7E7), //light grey colour
      ),
    );
  }
}
