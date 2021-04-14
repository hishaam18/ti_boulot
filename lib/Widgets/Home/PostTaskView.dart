import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostTaskView extends StatefulWidget {
  @override
  _PostTaskViewState createState() => _PostTaskViewState();
}

class _PostTaskViewState extends State<PostTaskView> {
  List<Step> steps = [
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
              ),
              labelText: 'Task Description',
              labelStyle: TextStyle(
                fontSize: 18.0,
                fontFamily: 'StemRegular',
              ),
              hintText: 'E.g. There are 3 rooms of 50m2 each.',
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
            ),
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
          TextFormField(
            decoration: InputDecoration(labelText: 'Date'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Time'),
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
            decoration: InputDecoration(labelText: 'What is the budget'),
          ),
        ],
      ),
    ),
  ];

  int currentStep = 0;
  bool complete = false;

  //move to next step
  next() {
    currentStep + 1 != steps.length
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
      body: Column(
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
                    steps: steps,
                    type: stepperType,
                    currentStep: currentStep,
                    onStepContinue: next,
                    onStepTapped: (step) => goTo(step),
                    onStepCancel: cancel,
                  ),
                ),
        ],
      ),

      //floating action button which activates switch step
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepType,
      ),
    );
  } //BuildContext

}
