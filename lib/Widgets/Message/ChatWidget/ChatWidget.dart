import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ConversationModel.dart';
import 'package:ti_boulot/Widgets/Message/ChatDetails/dart/ChatDetailsPage.dart';
import 'package:ti_boulot/Widgets/Message/ChatWidget/ChatWidgetController.dart';

class ChatWidget extends StatefulWidget {
  final ConversationModel data;
  ChatWidget({this.data});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  ChatWidgetController chatWidgetController = new ChatWidgetController();

  @override
  Widget build(BuildContext context) {
    Random random = new Random();

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetailsPage(
                        workerID: widget.data.userID,
                        name:
                            widget.data.firstName + " " + widget.data.lastName,
                        conversationID: widget.data.conversationId,
                      )),
            );

            // print(widget.data.firstName +
            //     " " +
            //     widget.data.lastName +
            //     " with conversation id ${widget.data.conversationId} tapped!");
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.grey[400].withOpacity(0.4),
              // color: Color(0xFF673ab7).withOpacity(0.3),
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  //taking random pictures from the avatar list and assigning to users
                  backgroundImage: ExactAssetImage(
                      "images/avatars/${Common.avatars[random.nextInt(Common.avatars.length)]}"

                      //  "${Common.avatarPath}",
                      ),

                  minRadius: 35,
                  maxRadius: 35,
                ),
                SizedBox(
                  width: 30.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 220.0,
                      child: Text(
                        widget.data.firstName + " " + widget.data.lastName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${DateAndTime.getTimeFromTimestamp(widget.data.timestamp.toString())} on ${DateAndTime.getDateFromTimestamp(widget.data.timestamp.toString())}",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
