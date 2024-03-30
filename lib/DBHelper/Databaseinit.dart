
import 'dbhelper.dart';

class DatabaseInit {
  static void initialize() async {
    await DatabaseHandler().initializeDB();
  }
}
