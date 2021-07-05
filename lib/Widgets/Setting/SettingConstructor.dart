class UserProfileDetail {
  String firstName;
  String lastName;
  String email;
  String address;
  String rating;
  UserProfileDetail(
      {this.firstName, this.lastName, this.email, this.address, this.rating});

  UserProfileDetail fromJson(Map<String, dynamic> json) {
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.email = json['emailAddress'];
    this.address = json['address'];
    this.rating = json['starRating'].toString();
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailAddress'] = this.email;
    data['address'] = this.address;
    data['starRating'] = this.rating;
    return data;
  }
}
