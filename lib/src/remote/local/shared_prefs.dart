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
  void removeProduct() {
    _prefs.remove('product');
  }
}
