import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Common/ConversationModel.dart';
import 'package:ti_boulot/Widgets/Message/ChatDetails/dart/ChatDetailsController.dart';
import 'package:ti_boulot/Widgets/Message/ChatWidget/ChatWidget.dart';
import 'package:ti_boulot/main.dart';

class ChatDetailsPage extends StatefulWidget {
  final String name;
  final String conversationID;

  ChatDetailsPage({this.name, this.conversationID});

  @override
  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  ChatDetailsController chatDetailsController = new ChatDetailsController();

  ScrollController scrollController = new ScrollController();

  Timer timer;

  callSetState() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(
        Duration(milliseconds: 500), (timer) => checkForMessages());
    getChatFromConversation(widget.conversationID);
  }

  checkForMessages() async {
    int msgAmount =
        await chatDetailsController.checkMessage(widget.conversationID);
    if (msgAmount != 0 && msgAmount != chatDetailsController.chats.length) {
      getChatFromConversation(widget.conversationID);
    }
  }

  getChatFromConversation(String conversationID) async {
    await chatDetailsController.getChat(conversationID, callSetState);
    scrollController.animateTo(
        (chatDetailsController.chatList.length * 500).toDouble(),
        duration: Duration(milliseconds: 500),
        curve: Curves.ease);

    setState(() {
      chatDetailsController.loadingWidget = Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false), // returns to previous page
          color: Colors.white,
        ),
        actions: [
          //refresh button
          chatDetailsController.loadingWidget,
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: chatDetailsController.chatList,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100.0,
              child: Row(
                children: [
                  SizedBox(
                    width: 15.0,
                  ),
                  Form(
                    key: chatDetailsController.messageKey,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100,
                      height: 100.0,
                      child: TextFormField(
                        controller: chatDetailsController.textController,
                        // onSaved: (email) => email = email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (message) {
                          if (message.isEmpty)
                            return "Message cannot be empty";
                          else
                            return null;
                        },
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'StemRegular',
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 50.0, left: 25.0),
                          labelText: 'Type your message...',
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'StemRegular',
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                        ),
                        // onChanged: (value) {
                        //   email = value;
                        // },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    onTap: () async {
                      if (chatDetailsController.messageKey.currentState
                          .validate()) {
                        setState(() {
                          chatDetailsController.sendIcon = SpinKitChasingDots(
                            color: Colors.white,
                            size: 24.0,
                          );
                        });

                        await chatDetailsController.sendMessage(
                            scrollController,
                            chatDetailsController.textController.text,
                            widget.conversationID,
                            context,
                            getChatFromConversation,
                            callSetState);

                        setState(() {
                          chatDetailsController.sendIcon = Icon(
                            Icons.send,
                            size: 28.0,
                            color: Colors.white,
                          );
                        });
                      }
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF673ab7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: chatDetailsController.sendIcon,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReceivedMessage extends StatefulWidget {
  final String message, date, time;
  ReceivedMessage({this.message, this.date, this.time});
  @override
  _ReceivedMessageState createState() => _ReceivedMessageState();
}

class _ReceivedMessageState extends State<ReceivedMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7.5,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      color: Color(0xff694f91),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: Text(
                        widget.message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.time,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(widget.date),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7.5,
        ),
      ],
    );
  }
}

class SentMessage extends StatefulWidget {
  final String message, date, time;
  SentMessage({this.message, this.date, this.time});
  @override
  _SentMessageState createState() => _SentMessageState();
}

class _SentMessageState extends State<SentMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7.5,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40.0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.time,
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(widget.date),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      color: Color(0xff563a5e),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      child: Text(
                        widget.message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 7.5,
        ),
      ],
    );
  }
}

class EmptyChat extends StatefulWidget {
  @override
  _EmptyChatState createState() => _EmptyChatState();
}

class _EmptyChatState extends State<EmptyChat> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 100.0,
        ),
        Container(
          child: Text(
            "This chat is empty!",
            style: TextStyle(fontSize: 32.0),
          ),
        ),
      ],
    ));
  }
}