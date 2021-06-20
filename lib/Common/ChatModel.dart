class ChatModel {
  int messageId;
  String conversationId;
  String senderId;
  String receiverId;
  String message;
  String timestamp;

  ChatModel(
      {this.messageId,
      this.conversationId,
      this.senderId,
      this.receiverId,
      this.message,
      this.timestamp});

  ChatModel fromJson(Map<String, dynamic> json) {
    this.messageId = json['Message_Id'];
    this.conversationId = json['Conversation_Id'];
    this.senderId = json['Sender_Id'];
    this.receiverId = json['Receiver_Id'];
    this.message = json['Message'];
    this.timestamp = json['Timestamp'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message_Id'] = this.messageId;
    data['Conversation_Id'] = this.conversationId;
    data['Sender_Id'] = this.senderId;
    data['Receiver_Id'] = this.receiverId;
    data['Message'] = this.message;
    data['Timestamp'] = this.timestamp;
    return data;
  }
}
