part of lib_service;

/*
  https://pub.dev/packages/sqflite
  Can use sqflite
*/

class DataProvider {
  static late String _path;

  openDB() async {
    Directory databasesPath = await getApplicationDocumentsDirectory();
    _path = join(databasesPath.path, dataBaseName);
    return await openDatabase(_path, version: 1);
  }

  initDataBase() async {
    Database db = await openDB();
    for (var table in dataTable) {
      bool isExist = await isExistTable(db, table);
      if (!isExist) {
        var sql = 'CREATE TABLE $table (id INTEGER PRIMARY KEY, value TEXT)';
        await db.execute(sql);
        debugPrint('===> $table create successful');
      }
    }
  }

  createTable(String table) async {
    Database db = await openDB();
    var sql = 'CREATE TABLE $table (id INTEGER PRIMARY KEY, value TEXT)';
    bool isExist = await isExistTable(db, table);
    if (!isExist) db.execute(sql);
    db.close();
  }

  deleteTable(String table) async {
    Database db = await openDB();
    var sql = 'DELETE FROM $table';
    await db.execute(sql);
    db.close();
  }

  isExistTable(Database db, String table) async {
    String sql = 'SELECT COUNT(*) FROM $table';
    try {
      Sqflite.firstIntValue(await db.rawQuery(sql));
      return true;
    } catch (e) {
      return false;
    }
  }

  getAllData(Database db, String table) async {
    List<Map> results = await db.rawQuery("SELECT value FROM $table");
    return results;
  }

  getDataById(String table, int id) async {
    Database db = await openDB();
    List<Map> results =
        await db.rawQuery("SELECT value FROM $table WHERE id = $id");
    db.close();
    return results;
  }

  updateMore(String table, List<int> ids, List<String> values) async {
    if (ids.isNotEmpty && values.isNotEmpty) {
      Database db = await openDB();
      String value = '';
      for (var i = 0; i < ids.length; i++) {
        value += '(${ids[i]}, ${values[i]})';
        if (i < ids.length - 1) value += ',';
      }
      var sql = 'INSERT INTO $table (id, value) VALUES $value';
      db.execute(sql);
      db.close();
    } else {
      throw ('ids and values can not empty');
    }
  }

  update(String table, int id, String value) {
    late bool isExits;
    try {
      openDB().then((db) async {
        isExits = await isExist(db, table, id);
        if (isExits) {
          await db.rawUpdate(
              'UPDATE $table SET value = ? WHERE id = ?', [value, id]);
        } else {
          await db.rawInsert(
              'INSERT INTO $table (id, value) VALUES (?, ?)', [id, value]);
        }
        //db.close();
      });
    } catch (e) {
      print("Error Update table $table id $id isExist $isExits: $e");
    }
  }

  delete(String table, List<int> ids) async {
    Database db = await openDB();
    var sql = 'delete from $table where id IN $ids'
        .replaceAll('[', '(')
        .replaceAll(']', ')');
    db.execute(sql);
    db.close();
  }

  isExist(Database db, String table, int id) async {
    try {
      String sql = 'SELECT COUNT(*) FROM $table where id = $id';
      int? count = Sqflite.firstIntValue(await db.rawQuery(sql));
      return count == 0 ? false : true;
    } catch (e) {
      debugPrint('Error isExits table $table id $id: $e');
      return false;
    }
  }

  deleteDB() async {
    await deleteDatabase(_path);
  }
}
