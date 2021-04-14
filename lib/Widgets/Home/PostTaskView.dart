import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostTaskView extends StatefulWidget {
  @override
  _PostTaskViewState createState() => _PostTaskViewState();
}

class _PostTaskViewState extends State<PostTaskView> {
  DateTime selectedDate = DateTime.now();
  String displayDate; //send this one to database
  bool dateChosenCheck = false;

  int currentStep = 0;
  bool complete = false;

  //move to next step
  next() {
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

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            complete
                ? Expanded(
                    child: Center(
                      child: AlertDialog(
                        title: new Text(" Task Posted "),
                        content: new Text(
                          "You have successfully Posted a task!",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Close"),
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
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                maxLines: 8,
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
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
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
                                  labelText: 'Location',
                                  labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'StemRegular',
                                  ),
                                  hintText: 'Royal Road, Curepipe',
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
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
                                          ? 'Chosen date: ' + displayDate
                                          : 'Click on button to choose date',
                                      style: TextStyle(fontSize: 18.0),
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
                                              selectedDate, // Refer step 1
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(
                                              DateTime.now().year.toInt() + 3),
                                        );
                                        if (picked != null &&
                                            picked != selectedDate)
                                          setState(() {
                                            dateChosenCheck = true;
                                            selectedDate = picked;

                                            displayDate = convertDateToReadable(
                                                selectedDate.toString());
                                          });
                                      },
                                      child: Icon(Icons.calendar_today),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Step(
                          isActive: true,
                          state: StepState.editing,
                          title: const Text('Budget'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'What is the budget'),
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
