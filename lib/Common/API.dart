import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ti_boulot/Common/ResponseType.dart';

class API {
  Future<ResponseType> post(String url, var body) async {
    var apiResponse = await http.post(url, body: body);

    //stringResponse to JSON
    Map<String, dynamic> mapJSON = jsonDecode(apiResponse.body);

    //convert json to responseType and return
    return ResponseType().fromJson(mapJSON);
  }
}
