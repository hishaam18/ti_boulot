import 'package:ti_boulot/Common/API.dart';
import 'package:ti_boulot/Common/Common.dart';
import 'package:ti_boulot/Common/ResponseType.dart';
import 'package:ti_boulot/Common/ApiURL.dart';

/*  *****************    Getting PostTask values from Backend     ********************    */

class BrowseController {
  Future<void> retrieveTask() async {
    var body = {};

    //getting response from backend from: (app.use/login)
    ResponseType response =
        await API().post(ApiURL.getURL(ApiURL.retrieveTask), body);

    //print response
    print(response.success);

    //
    if (response.success) {
      print(response.data);
      // Common.taskData = ;

    }
  }
}
