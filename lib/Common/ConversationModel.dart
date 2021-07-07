import 'package:ti_boulot/Common/Common.dart';

class ConversationModel {
  String userID;
  String firstName;
  String lastName;
  String avatarPath;
  String conversationId;
  DateTime timestamp;

  ConversationModel(
      {this.userID,
      this.firstName,
      this.lastName,
      this.avatarPath,
      this.conversationId,
      this.timestamp});

  ConversationModel fromJson(Map<String, dynamic> json) {
    this.userID = json['User_ID'].toString();
    this.firstName = json['First_Name'];
    this.lastName = json['Last_Name'];
    this.avatarPath = json['Avatar_Path'];
    this.conversationId = json['Conversation_Id'].toString();
    this.timestamp = DateAndTime.sqlToFlutterDate(json['Timestamp']);
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_ID'] = this.userID;
    data['First_Name'] = this.firstName;
    data['Last_Name'] = this.lastName;
    data['Avatar_Path'] = this.avatarPath;
    data['Conversation_Id'] = this.conversationId;
    data['Timestamp'] = this.timestamp;
    return data;
  }
}
