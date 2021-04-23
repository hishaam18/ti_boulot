//put the response into an object
//access success by response.success
//instead of response['success']
class ResponseType {
  bool success;
  String error;
  Map<String, dynamic> data;
  String msg;

  ResponseType({this.success, this.error, this.data, this.msg});

  ResponseType fromJson(Map<String, dynamic> json) {
    this.success = json['success'];
    this.error = json['error'];
    this.data = json['data'];
    this.msg = json['msg'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    data['data'] = this.data;
    data['msg'] = this.msg;
    return data;
  }
}
