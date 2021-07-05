import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/ChatModel.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Widgets/Message/ChatDetails/dart/ChatDetailsConstructor.dart';
import 'package:ti_boulot/Widgets/Message/ChatDetails/dart/ChatDetailsPage.dart';

class ChatDetailsController {
  List<Widget> chatList = [EmptyChat()];
  List<ChatModel> chats = new List<ChatModel>();

  TextEditingController textController = new TextEditingController();

  final messageKey = GlobalKey<FormState>();

  Widget sendIcon = Icon(
    Icons.send,
    size: 28.0,
    color: Colors.white,
  );

  Widget loadingWidget = Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Container(
      width: 50.0,
      height: 50.0,
      child: SpinKitChasingDots(
        size: 32.0,
        color: Colors.white,
      ),
    ),
  );

  Future<int> checkMessage(String conversationID) async {
    var body = {"conversationID": conversationID};

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.getChatFromConversationID), body);
    List<ChatModel> checkChats = new List<ChatModel>();
    if (response.success) {
      for (int i = 0; i < response.data.length; i++) {
        checkChats.add(ChatModel().fromJson(response.data[i]));
      }
    }

    return checkChats.length;
  }

  Future<void> getChat(String conversationID, Function callSetState) async {
    var body = {"conversationID": conversationID};

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.getChatFromConversationID), body);

    if (response.success) {
      if (response.data.length != 0) {
        chatList.clear();
        chats.clear();
      }

      for (int i = 0; i < response.data.length; i++) {
        chats.add(ChatModel().fromJson(response.data[i]));
      }

      ChatModel tempChat;

      for (int i = 1; i < chats.length; i++) {
        for (int j = i; j > 0; j--) {
          if (DateAndTime.compareFlutterDatesReversed(
              DateAndTime.sqlToFlutterDate(chats[j].timestamp.toString()),
              DateAndTime.sqlToFlutterDate(
                  chats[j - 1].timestamp.toString()))) {
            tempChat = chats[j];
            chats[j] = chats[j - 1];
            chats[j - 1] = tempChat;
          }
        }
      }

      for (var message in chats) {
        if (message.senderId == Common.userID) {
          chatList.add(
            SentMessage(
                message: message.message,
                date: message.timestamp[8] +
                    message.timestamp[9] +
                    "/" +
                    message.timestamp[5] +
                    message.timestamp[6] +
                    "/" +
                    message.timestamp[2] +
                    message.timestamp[3],
                time: message.timestamp[11] +
                    message.timestamp[12] +
                    ":" +
                    message.timestamp[14] +
                    message.timestamp[15]),
          );
        } else {
          chatList.add(ReceivedMessage(
              message: message.message,
              date: message.timestamp[8] +
                  message.timestamp[9] +
                  "/" +
                  message.timestamp[5] +
                  message.timestamp[6] +
                  "/" +
                  message.timestamp[2] +
                  message.timestamp[3],
              time: message.timestamp[11] +
                  message.timestamp[12] +
                  ":" +
                  message.timestamp[14] +
                  message.timestamp[15]));
        }
      }

      callSetState();
    }
  }

  Future<void> sendMessage(
      ScrollController scrollController,
      String message,
      String conversationID,
      BuildContext context,
      Function loadMessages,
      Function callSetState) async {
    var body = {
      "conversationID": conversationID,
      "senderID": Common.userID,
      "message": message,
      "timestamp": DateAndTime.flutterToSqlDate(DateTime.now()),
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.sendMessage), body);

    if (response.success) {
      textController.clear();
      loadingWidget = Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          width: 50.0,
          height: 50.0,
          child: SpinKitChasingDots(
            size: 32.0,
            color: Colors.white,
          ),
        ),
      );
      callSetState();
      await loadMessages(conversationID);
    }
  }

  Future<UserDetailRating> displayRating(String workerID) async {
    var body = {
      "Worker_ID": workerID,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.displayRating), body);

    UserDetailRating userDetailRating =
        UserDetailRating().fromJson(response.data);

    return userDetailRating;
  }
}
