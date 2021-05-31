//Constructor to create and initialise all variables of an object(BrowseControllerConstructor)
//The object is the one returned from API(server) ie response from receiveTask function
class WorkerBrowseConstructor {
  int taskID;
  int userID;
  String title;
  String taskDescription;
  double lat;
  double lng;
  int budget;
  String datePosted;
  String dateDeadline;

  WorkerBrowseConstructor(
      {this.taskID,
      this.userID,
      this.title,
      this.taskDescription,
      this.lat,
      this.lng,
      this.budget,
      this.datePosted,
      this.dateDeadline});

  WorkerBrowseConstructor.fromJson(Map<String, dynamic> json) {
    this.taskID = json['Task_ID'];
    this.userID = int.parse(json['User_ID']);
    this.title = json['Title'];
    this.taskDescription = json['Task_Description'];
    this.lat = double.parse(json['lat']);
    this.lng = double.parse(json['lng']);
    this.budget = json['Budget'];
    this.datePosted = json['Date_Posted'];
    this.dateDeadline = json['Date_Deadline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Task_ID'] = this.taskID;
    data['User_ID'] = this.userID;
    data['Title'] = this.title;
    data['Task_Description'] = this.taskDescription;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['Budget'] = this.budget;
    data['Date_Posted'] = this.datePosted;
    data['Date_Deadline'] = this.dateDeadline;
    return data;
  }
}
