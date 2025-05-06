import 'package:hive_flutter/hive_flutter.dart';
import '../models/app_settings.dart';
import '../models/favorite_hotel.dart';

class HiveService {
  static const String _settingsBoxName = 'settings';
  static const String _settingsKey = 'app_settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(FavoriteHotelAdapter());
    await Hive.openBox<AppSettings>(_settingsBoxName);
  }

  static Box<AppSettings> get _settingsBox => 
      Hive.box<AppSettings>(_settingsBoxName);

  static AppSettings get settings {
    final settings = _settingsBox.get(_settingsKey);
    if (settings == null) {
      final newSettings = AppSettings();
      _settingsBox.put(_settingsKey, newSettings);
      return newSettings;
    }
    return settings;
  }

  static Future<void> saveSettings(AppSettings settings) async {
    await _settingsBox.put(_settingsKey, settings);
  }

  static Future<void> updateLastSelectedTab(int index) async {
    final currentSettings = settings;
    currentSettings.lastSelectedTab = index;
    await saveSettings(currentSettings);
  }

  static Future<void> addSavedHotel(String hotelId) async {
    final currentSettings = settings;
    if (!currentSettings.savedHotels.contains(hotelId)) {
      currentSettings.savedHotels.add(hotelId);
      await saveSettings(currentSettings);
    }
  }

  static Future<void> removeSavedHotel(String hotelId) async {
    final currentSettings = settings;
    currentSettings.savedHotels.remove(hotelId);
    await saveSettings(currentSettings);
  }

  static Future<void> addBooking(String bookingId) async {
    final currentSettings = settings;
    if (!currentSettings.bookings.contains(bookingId)) {
      currentSettings.bookings.add(bookingId);
      await saveSettings(currentSettings);
    }
  }

  static Future<void> removeBooking(String bookingId) async {
    final currentSettings = settings;
    currentSettings.bookings.remove(bookingId);
    await saveSettings(currentSettings);
  }
} 