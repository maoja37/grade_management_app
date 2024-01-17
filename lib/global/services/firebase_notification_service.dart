import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grade_management_app/global/utils/extensions.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessages(RemoteMessage message) async {
    'Handling a background message '.log();


  }

  Future<void> initNotificationService() async {
  
                                
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
      );
      'User granted permission: ${settings.authorizationStatus}'.log();
      String? token = await _firebaseMessaging.getToken();
      'FirebaseMessaging token: $token'.log();
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

  }
}