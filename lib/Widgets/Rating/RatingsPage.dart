import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Widgets/Rating/rating.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Flutter Rating Control", home: RatingsPage());
  }
}

class RatingsPage extends StatefulWidget {
  final String workerID;

  RatingsPage({this.workerID});
  int _rating;

  @override
  _RatingsPage createState() => _RatingsPage();
}

class _RatingsPage extends State<RatingsPage> {
  @override
  Widget build(BuildContext context) {
    RatingsPage ratingsPage = new RatingsPage();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Padding(
            padding: const EdgeInsets.only(left: 107.0),
            child: Text(
              'Rating',
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Rating(
                onRatingSelected: (rating) {
                  setState(() {
                    ratingsPage._rating = rating;
                  });
                },
                workerID: widget.workerID,
                maximumRating: 5,
              ),
              SizedBox(
                  height: 44,
                  child:
                      (ratingsPage._rating != null && ratingsPage._rating != 0)
                          ? Text("You selected ${ratingsPage._rating} ",
                              style: TextStyle(fontSize: 18))
                          : SizedBox.shrink())
            ],
          ),
        ));
  }

  RatingsPage ratingsPage = new RatingsPage();
}

class RatingController {
  Future<void> sendStars(
      String workerID, int stars, BuildContext context) async {
    var body = {
      "User_ID": Common.userID,
      "worker_ID": workerID,
      "rating": stars.toString(),
      //  "displayDate": displayDate,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.sendRating), body);

    if (response.success) {
      Navigator.pop(context);
    }
  } //end Future<void>

}
