import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 95.0),
          child: Text(
            'Message',
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
    );
  }
}
