import 'package:flutter_application_1/core/models/client.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ClientDatabaseHelper {
  static final ClientDatabaseHelper _instance =
      ClientDatabaseHelper._internal();
  static Database? _database;

  factory ClientDatabaseHelper() => _instance;

  ClientDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'client_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clients(
        email TEXT PRIMARY KEY,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        password TEXT NOT NULL,
        idImagePath TEXT
      )
    ''');
  }

  Future<bool> insertClient(Client client, String password) async {
    try {
      final db = await database;
      await db.insert(
        'clients',
        {
          'email': client.email,
          'firstName': client.firstName,
          'lastName': client.lastName,
          'phoneNumber': client.phoneNumber,
          'password': password, 
          'idImagePath': client.idImagePath,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      print('Error inserting client: $e');
      return false;
    }
  }

  Future<Client?> getClient(String email) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'clients',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (maps.isEmpty) return null;

      return Client(
        firstName: maps[0]['firstName'],
        lastName: maps[0]['lastName'],
        phoneNumber: maps[0]['phoneNumber'],
        email: maps[0]['email'],
        idImagePath: maps[0]['idImagePath'],
      );
    } catch (e) {
      print('Error getting client: $e');
      return null;
    }
  }

  Future<bool> validateClient(String email, String password) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'clients',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password], // In a real app, compare hashed passwords
      );
      return maps.isNotEmpty;
    } catch (e) {
      print('Error validating client: $e');
      return false;
    }
  }

  Future<bool> deleteClient(String email) async {
    try {
      final db = await database;
      await db.delete(
        'clients',
        where: 'email = ?',
        whereArgs: [email],
      );
      return true;
    } catch (e) {
      print('Error deleting client: $e');
      return false;
    }
  }
}
