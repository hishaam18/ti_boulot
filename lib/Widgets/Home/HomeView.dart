import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 113.0),
          child: Text(
            'Home',
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
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        curve: Curves.easeInQuad,
        backgroundColor: Colors.deepPurple,
        items: [
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.notifications, title: 'Notifications'),
          TabItem(icon: Icons.add_circle_outline, title: 'Browse'),
          TabItem(icon: Icons.inventory, title: 'MyTasks'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) => print('click index=$i'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),

        //onPressed -> floating action button
        onPressed: () {
          Navigator.pushNamed(context, '/PostTask');
        },
      ),
    );
  }
}
