class ApiURL {
  static String baseURL = 'http://10.0.2.2:9000/';
  //static String baseURL = 'http://localhost:9000/';
  //static String baseURL = 'http://192.168.100.61:9000/';

  static String reverseGeocodingURLKey = "7Ty3EwM0hCwAKhvXSTXqAIP3T2jAbxxr";
  static String reverseGeocodingURL =
      "http://www.mapquestapi.com/geocoding/v1/reverse?key=$reverseGeocodingURLKey";

  static const String login = 'login';
  static const String register = 'register';
  static const String postTask = 'postTask';
  static const String retrieveTask = 'retrieveTask';

  static String getURL(String url) {
    return baseURL + url.toString();
  }
}
