class ApiURL {
  // static String baseURL = 'http://10.0.2.2:9000/';
  static String baseURL = 'http://192.168.100.61:9000/';
  //static String baseURL = 'http://localhost:9000/';
  //static String baseURL = 'http://192.168.100.61:9000/';

  static String reverseGeocodingURLKey = "7Ty3EwM0hCwAKhvXSTXqAIP3T2jAbxxr";
  static String reverseGeocodingURL =
      "http://www.mapquestapi.com/geocoding/v1/reverse?key=$reverseGeocodingURLKey";

  //string storing end of paths
  static const String login = 'login';
  static const String register = 'register';
  static const String postTask = 'postTask';
  static const String retrieveTask = 'retrieveTask';
  static const String getMyTasks = 'getMyTasks';
  static const String workerRetrieveTask = 'workerRetrieveTask';
  static const String workerSendOffer = 'workerSendOffer';
  static const String getChatListForUser = 'getChatListForUser';
  static const String getAvatarForUser = 'getAvatarForUser';
  static const String getChatFromConversationID = 'getChatFromConversationID';
  static const String sendMessage = 'sendMessage';
  static const String sendRating = 'sendRating';
  static const String displayRating = 'displayRating';
  static const String displayProfile = 'displayProfile';
  static const String setAvatar = 'setAvatar';
  static const String sendTaskRating = 'sendTaskRating';
  static const String allTaskData = 'allTaskData';
  static const String offerDetails = 'offerDetails';
  static const String detailsTakenBy = 'detailsTakenBy';
  static const String getTaskDataByID = 'getTaskDataByID';

  //creating paths
  static String getURL(String url) {
    return baseURL + url.toString();
  }
}
