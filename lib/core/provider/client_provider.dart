import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/core/models/client.dart';
import 'package:flutter_application_1/database/client_database_helper.dart';

class ClientProvider with ChangeNotifier {
  final ClientDatabaseHelper _dbHelper = ClientDatabaseHelper();
  Client? _currentClient;
  bool _isLoading = false;
  String? _error;

  // Getters
  Client? get currentClient => _currentClient;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentClient != null;

  // Private setters
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  // Authentication methods
  Future<bool> login(String email, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      final isValid = await _dbHelper.validateClient(email, password);
      if (!isValid) {
        _setError('Invalid email or password');
        return false;
      }

      final client = await _dbHelper.getClient(email);
      if (client == null) {
        _setError('User not found');
        return false;
      }

      _currentClient = client;
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signup(Client client, String password) async {
    try {
      _setLoading(true);
      _setError(null);

      // Check if email already exists
      final existingClient = await _dbHelper.getClient(client.email);
      if (existingClient != null) {
        _setError('Email already registered');
        return false;
      }

      final success = await _dbHelper.insertClient(client, password);
      if (!success) {
        _setError('Failed to create account');
        return false;
      }

      _currentClient = client;
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);
      _currentClient = null;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _setError(null);
  }
}
