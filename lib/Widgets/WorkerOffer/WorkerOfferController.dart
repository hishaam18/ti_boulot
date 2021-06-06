import 'package:flutter/cupertino.dart';

class WorkerOfferController {
  final WorkerOfferKey = GlobalKey<FormState>();

  String workerDisplayDate; //availability - creating a global variable
  String workerDisplayDeadlineDate;
  DateTime selectedDate = DateTime.now();
}
