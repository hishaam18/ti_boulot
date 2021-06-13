import 'package:flutter/cupertino.dart';
import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class WorkerOfferController {
  final WorkerOfferKey = GlobalKey<FormState>();

  TextEditingController offeringPriceController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();

  String workerDisplayDate = ""; //availability - creating a global variable
  String workerDisplayDeadlineDate = "";
  DateTime selectedDate = DateTime.now();

  Future<void> sendOffer(String offeringPrice, comment, workerDisplaydate,
      workerDeadlineDate) async {
    var body = {
      "User_ID": Common.userID,
      "offeringPrice": offeringPrice,
      "comment": comment,
      "workerDisplayDate": workerDisplayDate,
      "workerDeadlineDate": workerDisplayDeadlineDate,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.workerSendOffer), body);
  }
}
