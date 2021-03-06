import 'dart:convert';

import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Widgets/MyTask/Content/offerConstructor.dart';
import 'package:ti_boulot/Widgets/MyTask/myTaskControllerConstructor.dart';

class ContentMyTaskController {
  List<offerConstructor> offers = new List<offerConstructor>();
  List<String> dropdownItems = new List<String>();
  Map<String, String> offerUser = new Map<String, String>();
  String selectedValue;

  //---------- UPDATE task table------///
  Future<void> taskRating(String taskID, taskRating) async {
    var body = {
      "taskID": taskID,
      "taskRating": taskRating,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.sendTaskRating), body);
  }

//------------------ Get all task data to complete modal (conditions)---------------------------
  Future<void> allTaskData(String taskID) async {
    var body = {
      "taskID": taskID,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.allTaskData), body);

    if (response.success) {
      print(response.data);
    }
  }

//------------------ Get all offer details to put in modal ---------------------------
  Future<List<offerConstructor>> offerDetails(String taskID) async {
    var body = {
      "taskID": taskID,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.offerDetails), body);

    if (response.success) {
      offers.clear();
      for (var offer in response.data['offer_details']) {
        offers.add(offerConstructor.fromJson(offer));
      }

      dropdownItems.clear();
      for (var offer in offers) {
        String offerText = "An offer of ${offer.offeringPrice} was made. " +
            "\n" +
            "The worker left the following comments: '${offer.comment}'" +
            "\n";

        dropdownItems.add(offerText);
        offerUser[offerText] = offer.userID;
      }
    }
  }

  //----------------------------------- sending info for taken_by---------------------------------//

  Future<void> detailsTakenBy(String taskID, workerID) async {
    var body = {
      "taskID": taskID,
      "workerID": workerID,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.detailsTakenBy), body);
  }

  Future<myTaskControllerConstructor> getTaskDataByID(int taskID) async {
    var body = {
      "taskID": taskID.toString(),
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.getTaskDataByID), body);

    myTaskControllerConstructor taskData;

    if (response.success) {
      taskData = myTaskControllerConstructor().fromJson(response.data);
    }

    return taskData;
  }

  Future<void> deleteTask(String taskID) async {
    var body = {
      "taskID": taskID,
    };
    //deleteTask

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.deleteTaskDetails), body);
  }
}
