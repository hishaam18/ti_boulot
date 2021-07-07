import 'package:flutter/material.dart';
import 'package:ti_boulot/Widgets/Rating/RatingsPage.dart';

class Rating extends StatefulWidget {
  final Function(int) onRatingSelected;
  final String workerID;
  final int maximumRating;

  Rating({this.onRatingSelected, this.workerID, this.maximumRating});

  @override
  _Rating createState() => _Rating();
}

class _Rating extends State<Rating> {
  RatingController ratingController = new RatingController();

  bool showError = false;
  int _currentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }
  }

  Widget _buildBody() {
    RatingsPage ratingsPage = new RatingsPage();

    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
            if (_currentRating == 0)
              showError = true;
            else
              showError = false;
          });

          this.widget.onRatingSelected(_currentRating);
        },
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: stars,
            ),
            SizedBox(height: 15.0),
            showError
                ? Text(
                    "Rating cannot be 0 !",
                    style: TextStyle(color: Colors.red),
                  )
                : Container(),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () async {
                    if (_currentRating == 0) {
                      setState(() {
                        showError = true;
                      });
                    } else {
                      await ratingController.sendStars(
                          widget.workerID, _currentRating, context);
                    }
                    setState(() {
                      _currentRating = 0;
                    });
                    this.widget.onRatingSelected(_currentRating);
                  },
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  child: Text('Done'),
                ),
                SizedBox(width: 20.0),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _currentRating = 0;
                      if (_currentRating == 0) showError = true;
                    });
                    this.widget.onRatingSelected(_currentRating);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
