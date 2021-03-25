import 'package:market_matcher/services/database.dart';
import 'package:market_matcher/util/Cache.dart';

class CreateItemState {

  final DatabaseService _database = DatabaseService();

  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String _description = '';

  String get description => _description;

  set description(String value) {
    _description = value;
  }
  String _error = '';

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  String _price = '0';

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String _location = '';

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  CreateItemState();

  Future<void> submit() async {
    try {
      await _database.updateItemData(name, description, price, location, Cache.user);
    } catch (e) {
      rethrow;
    }
  }
}