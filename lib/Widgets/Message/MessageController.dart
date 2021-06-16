import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ConversationModel.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Widgets/Message/ChatWidget/ChatWidget.dart';

class MessageController {
  List<Widget> messageList =
      new List<Widget>(); //creating iterable/growing list (like arraylist)

  Widget bodyContent = SpinKitRotatingCircle(
    color: Colors.black,
    size: 50.0,
  ); //loading circle

  Widget refreshBtnIcon = Icon(
    Icons.refresh,
    color: Colors.white,
    size: 30.0,
  );

  Future<List<Widget>> getChatList(Function callSetState) async {
    var body = {
      "User_ID": Common.userID,
    };

    //sending a post request to server(backend) with User_ID as body
    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.getChatListForUser), body);

    if (response.success) {
      messageList.clear();

      if (response.data.isEmpty) {
        messageList.add(Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            SvgPicture.asset(
              'images/emptyChat.svg',
              width: 300.0,
            ),
            SizedBox(
              height: 35.0,
            ),
            Text(
              'Empty Conversation List!',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ));
        callSetState();
      } else {
        for (int i = 0; i < response.data.length; i++) {
          ConversationModel conversation =
              ConversationModel().fromJson(response.data[i]);
          messageList.add(ChatWidget(
            data: conversation,
          ));
        }
        callSetState();
      }
    }
  }
}
