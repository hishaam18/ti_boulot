class ApiURL {
  static String baseURL = 'http://10.0.2.2:9000/';
  // static String baseURL = 'http://localhost:9000/';
  // static String baseURL = 'http://192.168.100.61:9000/';

  static const String login = 'login';
  static const String register = 'register';

  static String getURL(String url) {
    return baseURL + url.toString();
  }
}
