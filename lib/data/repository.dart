import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

import '../models/app_settings.dart';
import '../models/debt.dart';
import '../models/payment.dart';
import 'database.dart';

/// Truy cập dữ liệu cho khoản nợ, thanh toán và cấu hình.
class Repository {
  final AppDatabase _appDb;
  Repository({AppDatabase? appDb}) : _appDb = appDb ?? AppDatabase.instance;

  // ---- Debts ----

  Future<List<Debt>> getDebts() async {
    final db = await _appDb.database;
    final rows = await db.query('debts', orderBy: 'created_at ASC');
    return rows.map(Debt.fromMap).toList();
  }

  Future<Debt?> getDebt(int id) async {
    final db = await _appDb.database;
    final rows = await db.query('debts', where: 'id = ?', whereArgs: [id], limit: 1);
    return rows.isEmpty ? null : Debt.fromMap(rows.first);
  }

  Future<int> insertDebt(Debt debt) async {
    final db = await _appDb.database;
    final map = debt.toMap()..remove('id');
    return db.insert('debts', map);
  }

  Future<void> updateDebt(Debt debt) async {
    final db = await _appDb.database;
    await db.update('debts', debt.toMap(), where: 'id = ?', whereArgs: [debt.id]);
  }

  Future<void> deleteDebt(int id) async {
    final db = await _appDb.database;
    await db.delete('debts', where: 'id = ?', whereArgs: [id]);
  }

  // ---- Payments ----

  Future<List<Payment>> getPayments(int debtId) async {
    final db = await _appDb.database;
    final rows = await db
        .query('payments', where: 'debt_id = ?', whereArgs: [debtId], orderBy: 'date DESC');
    return rows.map(Payment.fromMap).toList();
  }

  /// Ghi 1 lần thanh toán và trừ dư nợ tương ứng trong cùng transaction.
  Future<void> addPayment(Payment payment) async {
    final db = await _appDb.database;
    await db.transaction((txn) async {
      await txn.insert('payments', payment.toMap()..remove('id'));
      final rows = await txn
          .query('debts', where: 'id = ?', whereArgs: [payment.debtId], limit: 1);
      if (rows.isNotEmpty) {
        final debt = Debt.fromMap(rows.first);
        var newBalance = debt.balance - payment.amount;
        if (newBalance < 0) newBalance = 0;
        await txn.update('debts', {'balance': newBalance},
            where: 'id = ?', whereArgs: [payment.debtId]);
      }
    });
  }

  Future<void> deletePayment(int paymentId) async {
    final db = await _appDb.database;
    await db.delete('payments', where: 'id = ?', whereArgs: [paymentId]);
  }

  // ---- Settings ----

  Future<AppSettings> getSettings() async {
    final db = await _appDb.database;
    final rows = await db.query('settings', where: 'id = 1', limit: 1);
    if (rows.isEmpty) return const AppSettings();
    return AppSettings.fromMap(rows.first);
  }

  Future<void> saveSettings(AppSettings settings) async {
    final db = await _appDb.database;
    await db.insert('settings', settings.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
