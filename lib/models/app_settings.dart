import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 0)
class AppSettings extends HiveObject {
  @HiveField(0)
  int lastSelectedTab;

  @HiveField(1)
  List<String> savedHotels;

  @HiveField(2)
  List<String> bookings;

  AppSettings({
    this.lastSelectedTab = 0,
    List<String>? savedHotels,
    List<String>? bookings,
  })  : savedHotels = savedHotels ?? [],
        bookings = bookings ?? [];
} 