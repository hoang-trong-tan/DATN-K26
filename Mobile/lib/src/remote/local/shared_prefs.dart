import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences _prefs;

  Future initialise() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get product {
    if (!_prefs.containsKey('product')) return null;

    return _prefs.getString('product');
  }

  set product(String? token) {
    _prefs.setString("product", token ?? "");
  }
  String? get fcmToken {
    if (!_prefs.containsKey('fcmToken')) return null;

    return _prefs.getString('fcmToken');
  }

  set fcmToken(String? token) {
    _prefs.setString("fcmToken", token ?? "");
  }

  void removeProduct() {
    _prefs.remove('product');
  }

  List<String>? get searchRecent {
    if (!_prefs.containsKey('searchRecent')) return null;

    return _prefs.getStringList('searchRecent');
  }

  set searchRecent(List<String>? value) {
    _prefs.setStringList("searchRecent", value ?? []);
  }

  void removeSearchRecent() {
    _prefs.remove('searchRecent');
  }

  String? get saveEmail {
    if (!_prefs.containsKey('saveEmail')) return null;

    return _prefs.getString('saveEmail');
  }

  set saveEmail(String? values) {
    _prefs.setString("saveEmail", values ?? "");
  }

  void removeAccount() {
    _prefs.remove('saveEmail');
    _prefs.remove('savePassword');
  }

  String? get savePassword {
    if (!_prefs.containsKey('savePassword')) return null;

    return _prefs.getString('savePassword');
  }

  set savePassword(String? values) {
    _prefs.setString("savePassword", values ?? "");
  }

  bool? get intro {
    if (!_prefs.containsKey('intro')) return null;

    return _prefs.getBool('intro');
  }

  set intro(bool? values) {
    _prefs.setBool("intro", values ?? false);
  }

  String? get token {
    if (!_prefs.containsKey('token')) return null;

    return _prefs.getString('token');
  }

  set token(String? values) {
    _prefs.setString("token", values ?? '');
  }

  void removeToken() {
    _prefs.remove('token');
  }
  String? get userName {
    if (!_prefs.containsKey('userName')) return null;

    return _prefs.getString('userName');
  }

  set userName(String? values) {
    _prefs.setString("userName", values ?? '');
  }
  void removeUserName() {
    _prefs.remove('userName');
  }
  String? get userID {
    if (!_prefs.containsKey('userID')) return null;

    return _prefs.getString('userID');
  }

  set userID(String? values) {
    _prefs.setString("userID", values ?? '');
  }
  void removeUserID() {
    _prefs.remove('userID');
  }

  bool? get userUpdate {
    if (!_prefs.containsKey('userEx')) return null;

    return _prefs.getBool('userEx');
  }

  set userUpdate(bool? value) {
    _prefs.setBool("userEx", value ??false);
  }

   void removeUpdate() {
    _prefs.remove('userEx');
  }
   void removerRole() {
    _prefs.remove('userRole');
  }

  String? get userRole {
    if (!_prefs.containsKey('userRole')) return null;

    return _prefs.getString('userRole');
  }

  set userRole(String? values) {
    _prefs.setString("userRole", values ?? '');
  }
}
