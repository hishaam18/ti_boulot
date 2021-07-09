class offerConstructor {
  int offerID;
  String userID;
  String taskID;
  String offeringPrice;
  String comment;
  String workerDisplayDate;
  String workerDeadlineDate;

  offerConstructor(
      {this.offerID,
      this.userID,
      this.taskID,
      this.offeringPrice,
      this.comment,
      this.workerDisplayDate,
      this.workerDeadlineDate});

  offerConstructor.fromJson(Map<String, dynamic> json) {
    offerID = json['Offer_ID'];
    userID = json['User_ID'];
    taskID = json['Task_ID'];
    offeringPrice = json['Offering_Price'];
    comment = json['Comment'];
    workerDisplayDate = json['Worker_Display_Date'];
    workerDeadlineDate = json['Worker_Deadline_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Offer_ID'] = this.offerID;
    data['User_ID'] = this.userID;
    data['Task_ID'] = this.taskID;
    data['Offering_Price'] = this.offeringPrice;
    data['Comment'] = this.comment;
    data['Worker_Display_Date'] = this.workerDisplayDate;
    data['Worker_Deadline_Date'] = this.workerDeadlineDate;
    return data;
  }
}
