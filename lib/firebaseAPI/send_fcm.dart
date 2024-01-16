import 'dart:convert';
import 'package:http/http.dart' as http;

Future sendMessage({required String title, required String body, required Map<String, dynamic> data}) async {
  
  // FCM Device Token of Receiver device
  String targetDeviceToken =
      "csyY1rQUSHWG_bOHrOAt0j:APA91bG0eSNeH5utaIhxgQsVLzH2scXh6X5cjuimjVj4_kDMqG4pO4Qkp0f65rJdDy1asfnvbAGVZwQYsrBceE9DQ5brGpawr-KkTeb-DTyEFh6KBI0MwQKEnn6ZuqTeK4xJbeRNcN3r";
  
  // Firebase project's Server key
  String serverKey =
      'AAAAYy97Dz4:APA91bGWKHFzPnxeD34U0FPoyKiLkk22KERcsY14zzqQ94swY5TCHocmBt5dM_QftKQISAipLzu6r7jsV2IqXcFHAAMLyEscYhc-tvn8cTvnO7ythSCO9FbS8NTkq1295AH6aavoJd-L';

  // Constructing the FCM message
  Map<String, dynamic> message = {
    'to': targetDeviceToken,
    'notification': {
      'title': title,
      'body': body
      // 'image': imageUrl 
    },
    "data": data
  };

  Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  http.post(url, headers: headers, body: jsonEncode(message)).then((response) {
    print('FCM message sent successfully');
    print('Response: ${response.body}');
  }).catchError((error) {
    print('Error sending FCM message: $error');
  });
}
