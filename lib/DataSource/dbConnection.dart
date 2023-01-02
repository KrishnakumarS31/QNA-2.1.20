
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbConnection {
  String appUser = "app_user";
  String id = "id";
  String locale = "locale";

  get dbConnection => null;

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'qnatest.db');

    return openDatabase(dbPath, version: 1, onCreate: populateDb);
  }

  Future<void> deleteDb() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'Arogya.db');
    await deleteDatabase(dbPath);
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE $appUser ("
        "$id number,"
        "$locale TEXT"
        ")");
  }
}
