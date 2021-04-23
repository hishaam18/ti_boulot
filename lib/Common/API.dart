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

  Future<dynamic> getAddress(
      String url, double latitude, double longitude) async {
    var body = {
      "location": {
        "latLng": {
          "lat": latitude.toStringAsFixed(7),
          "lng": longitude.toStringAsFixed(7)
        }
      },
      "options": {"thumbMaps": false},
      "includeNearestIntersection": true,
      "includeRoadMetadata": true
    };

    var apiResponse = await http.post(url, body: jsonEncode(body));

    //stringResponse to JSON
    Map<String, dynamic> mapJSON = jsonDecode(apiResponse.body);

    print(mapJSON['results'][0]['locations'][0]['street'] == ""
        ? mapJSON['results'][0]['locations'][0]['adminArea5'] +
            ", " +
            mapJSON['results'][0]['locations'][0]['adminArea3']
        : mapJSON['results'][0]['locations'][0]['street'] +
            ", " +
            mapJSON['results'][0]['locations'][0]['adminArea5'] +
            ", " +
            mapJSON['results'][0]['locations'][0]['adminArea3']);
  }
}
