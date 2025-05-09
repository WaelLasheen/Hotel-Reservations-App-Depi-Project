import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class HotelDatabase {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'hotels.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE hotels(
            id TEXT PRIMARY KEY,
            name TEXT,
            location TEXT,
            imageUrl TEXT,
            price REAL,
            rating REAL,
            reviewCount INTEGER,
            description TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertHotel(Hotel hotel) async {
    final db = await getDatabase();
    await db.insert('hotels', hotel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Hotel>> getHotels() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('hotels');
    return List.generate(maps.length, (i) => Hotel.fromMap(maps[i]));
  }

  static Future<void> updateFavorite(String id, bool isFav) async {
    final db = await getDatabase();
    await db.update('hotels', {'isFavorite': isFav ? 1 : 0}, where: 'id = ?', whereArgs: [id]);
  }
}
