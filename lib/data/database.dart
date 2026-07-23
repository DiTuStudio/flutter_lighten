import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Quản lý kết nối SQLite cục bộ. Không có server, không đồng bộ.
class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  static const _dbName = 'thoat_no.db';
  static const _dbVersion = 4;

  Database? _db;

  Future<Database> get database async {
    return _db ??= await _open();
  }

  Future<Database> _open() async {
    final dir = await getDatabasesPath();
    final path = p.join(dir, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE settings ADD COLUMN pro_temp_until INTEGER NOT NULL DEFAULT 0');
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE settings ADD COLUMN language_code TEXT');
    }
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE settings ADD COLUMN currency_code TEXT');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE debts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        balance REAL NOT NULL,
        original_principal REAL NOT NULL,
        annual_rate REAL NOT NULL,
        interest_type TEXT NOT NULL,
        minimum_payment REAL NOT NULL,
        due_day INTEGER NOT NULL,
        start_date INTEGER,
        note TEXT,
        created_at INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        debt_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date INTEGER NOT NULL,
        note TEXT,
        FOREIGN KEY (debt_id) REFERENCES debts (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        strategy TEXT,
        extra_per_month REAL NOT NULL DEFAULT 0,
        reminder_enabled INTEGER NOT NULL DEFAULT 0,
        reminder_hour INTEGER NOT NULL DEFAULT 9,
        reminder_minute INTEGER NOT NULL DEFAULT 0,
        is_pro INTEGER NOT NULL DEFAULT 0,
        pro_temp_until INTEGER NOT NULL DEFAULT 0,
        language_code TEXT,
        currency_code TEXT
      )
    ''');

    // Dòng settings mặc định.
    await db.insert('settings', {'id': 1});
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
