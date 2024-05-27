// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class AuthenticationService {
//   final _storage = FlutterSecureStorage();
//
//   Future<void> saveCredentials(String username, String password) async {
//     await _storage.write(key: 'username', value: username);
//     await _storage.write(key: 'password', value: password);
//   }
//
//   Future<Map<String, String>> getCredentials() async {
//     // Прочитайте значения как String?, но при возврате убедитесь, что они не null
//     String? username = await _storage.read(key: 'username');
//     String? password = await _storage.read(key: 'password');
//
//     // Здесь мы проверяем на null и в случае null возвращаем пустую строку или можно выбросить ошибку, если это критично
//     return {
//       'username': username ?? '', // Замена null на пустую строку, если username == null
//       'password': password ?? ''  // Замена null на пустую строку, если password == null
//     };
//   }
//
//   Future<bool> authenticate(String username, String password) async {
//     var storedCredentials = await getCredentials();
//     return storedCredentials['username'] == username && storedCredentials['password'] == password;
//   }
// }
