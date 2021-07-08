import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/ApiURL.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';

class ContentMyTaskController {
  Future<void> taskRating(String taskID, taskRating) async {
    var body = {
      "taskID": taskID,
      "taskRating": taskRating,
    };

    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.sendTaskRating), body);

    print(response.data);
  }
}
