import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/WorkerOffer/WorkerOfferController.dart';

class WorkerOfferView extends StatefulWidget {
  final int taskId;
  final int taskUserId;

  WorkerOfferView({this.taskId, this.taskUserId});

  @override
  _WorkerOfferViewState createState() => _WorkerOfferViewState();
}

class _WorkerOfferViewState extends State<WorkerOfferView> {
  WorkerOfferController workerOfferController =
      new WorkerOfferController(); //instance of WorkerOfferController to connect the two classes

  bool workerDateChosenCheck = false;

  //availability date variables
  DateTime selectedDate = DateTime.now();
  bool dateChosenCheck = false;

  //deadline date variables
  DateTime selectedDateSecond = DateTime.now();
  bool dateChosenCheckSecond = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 95.0),
          child: Text(
            'Offer',
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: workerOfferController.WorkerOfferKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: workerOfferController
                          .offeringPriceController, // to get variable created in controller
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'StemRegular',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        helperText: '  Numbers Only',
                        helperStyle: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'StemRegular',
                        ),
                        labelText: 'Offering Price (Rs)',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'StemRegular',
                        ),
                        hintText: 'E.g  1500',
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                        controller: workerOfferController
                            .commentController, //to get variable created in controller
                        maxLines: 6,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'StemRegular',
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          labelText: 'Comment',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'StemRegular',
                          ),
                          hintText: 'Add your work details here',
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                        )),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            workerDateChosenCheck
                                ? 'Potential starting time: '
                                : 'I can start on: ' +
                                    workerOfferController.workerDisplayDate,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'StemRegular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50.0,
                          color: Color(0xFF673ab7),
                          child: RaisedButton(
                            onPressed: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDateSecond, // Refer step 1
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime(DateTime.now().year.toInt() + 3),
                              );
                              if (picked != null &&
                                  picked != selectedDateSecond)
                                setState(() {
                                  dateChosenCheck = true;
                                  selectedDateSecond = picked;

                                  workerOfferController.workerDisplayDate =
                                      convertDateToReadable(
                                          selectedDateSecond.toString());
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
                                    workerOfferController
                                        .workerDisplayDeadlineDate
                                : 'I can complete the task by:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'StemRegular',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50.0,
                          color: Color(0xFF673ab7),
                          child: RaisedButton(
                            onPressed: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDateSecond, // Refer step 1
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime(DateTime.now().year.toInt() + 3),
                              );
                              if (picked != null &&
                                  picked != selectedDateSecond)
                                setState(() {
                                  dateChosenCheckSecond = true;
                                  selectedDateSecond = picked;

                                  workerOfferController
                                          .workerDisplayDeadlineDate =
                                      convertDateToReadable(
                                          selectedDateSecond.toString());
                                });
                            },
                            child: Icon(Icons.calendar_today),
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ), //date deadline
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        RaisedButton(
                            child: Text(
                              'Send Offer',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            color: Colors.deepPurple,
                            textColor: Colors.white70,
                            padding: EdgeInsets.all(10.0),
                            splashColor: Colors.white70,
                            onPressed: () async {
                              await workerOfferController.sendOffer(
                                widget.taskId,
                                widget.taskUserId,
                                workerOfferController
                                    .offeringPriceController.text,
                                workerOfferController.commentController.text,
                                workerOfferController.workerDisplayDate,
                                workerOfferController.workerDisplayDeadlineDate,
                              );

                              Navigator.pushNamed(context, '/MessageView');
                            }),
                        SizedBox(
                          width: 20.0,
                        ),
                        RaisedButton(
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            color: Colors.red,
                            textColor: Colors.white70,
                            padding: EdgeInsets.all(10.0),
                            splashColor: Colors.white70,
                            onPressed: () {
                              Navigator.pop(context, true);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String convertDateToReadable(String date) {
    return date.split(" ")[0].split("-")[2] +
        "-" +
        date.split(" ")[0].split("-")[1] +
        "-" +
        date.split(" ")[0].split("-")[0];
  }
}
