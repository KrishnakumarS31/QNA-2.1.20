import 'package:sqflite/sqflite.dart';
import 'dbConnection.dart';
import 'package:qna_test/Entity/app_user.dart';

class AppUserRepo {
  DbConnection dbConnection = DbConnection();

  Future<int> createUserDetail(AppUser user) async {
    final Database db = await dbConnection.createDatabase();
    int result = await db.insert(dbConnection.appUser, user.toMap());
    await db.close();
    return result;
  }

  Future<List<AppUser>> getUserDetails() async {
    final Database db = await dbConnection.createDatabase();
    List<Map<String, dynamic>> result = await db.query(dbConnection.appUser);
    await db.close();
    return List.generate(result.length, (i) {
      return AppUser.fromMap(result[i]);
    });
  }

  Future<AppUser?> getUserDetail() async {
    List<AppUser> users = await getUserDetails();
    if (users.isNotEmpty) {
      return users[0];
    }
    return null;
  }

  Future<int?> getUserDetailsCount() async {
    final Database db = await dbConnection.createDatabase();
    int? i = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ${dbConnection.appUser}'));
    await db.close();
    return i;
  }

  deleteUserDetail() async {
    final Database db = await dbConnection.createDatabase();
    await db.delete(dbConnection.appUser);
    await db.close();
  }

  Future<int> updateMobileNumber(AppUser user) async {
    final Database db = await dbConnection.createDatabase();
    return await db.update(dbConnection.appUser, user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  Future<int> updateLocale(AppUser user) async {
    final Database db = await dbConnection.createDatabase();
    return await db.rawUpdate(
        'UPDATE app_user SET locale = "${user.locale}" WHERE id = "${user.id}"');
    // await db.update(dbConnection.appUser, user.toMap(),
    //     where: "locale = ?", whereArgs: [user.locale]);
  }
}
