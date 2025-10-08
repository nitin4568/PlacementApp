
import 'package:placement/resource/url/config.dart';

class SocialLoginRepository {



  Future<dynamic> sendUserDataToAPI(String email) async {
    try {
      // Future me yahan tumhara API endpoint aayega
      final url = '${ApiConfig.baseUrl}${ApiConfig.apiVersion}social-login?userEmail=$email';


      return {'status': true, 'message': 'Login simulated successfully for $email'};
    } catch (e) {
      rethrow;
    }
  }
}
