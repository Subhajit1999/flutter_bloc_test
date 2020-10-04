import 'package:http/http.dart' as http;

class AuthenticationRepository {
  static const SERVER_ADDR = 'https://test.stree.org.in/v1/';

  Future<String> attemptLogIn(String email, String password) async {
    var res = await http.post(
        "$SERVER_ADDR/login",
        body: {
          "user": {
            "email": email,
            "password": password
          }
        }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }
}