import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ti_boulot/Widgets/Message/ChatWidget/ChatWidget.dart';
import 'package:ti_boulot/Widgets/Message/MessageController.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskController.dart';

//This is the main page for messages

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  MessageController messageController = new MessageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadChatList();
  }

  callSetState() {
    setState(() {});
  }

  loadChatList() async {
    setState(() {
      messageController.refreshBtnIcon = SpinKitChasingDots(
        color: Colors.white,
        size: 24.0,
      );
    });
    // await Future.delayed(Duration(seconds: 2));
    await messageController.getChatList(callSetState);
    setState(() {
      messageController.refreshBtnIcon = Icon(
        Icons.refresh,
        color: Colors.white,
        size: 30.0,
      );
    });
  }

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
          onPressed: () => Navigator.pushNamed(
              context, '/WorkerHomeView'), // returns to previous page

          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 60.0,
              child: Row(
                children: [
                  Text(
                    'Conversations',
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      await loadChatList();
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Color(0xFF673ab7),
                      ),
                      child: messageController.refreshBtnIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 225,
            child: SingleChildScrollView(
              child: Column(
                children: messageController.messageList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
