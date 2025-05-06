// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_hotel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHotelAdapter extends TypeAdapter<FavoriteHotel> {
  @override
  final int typeId = 2;

  @override
  FavoriteHotel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHotel(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      rating: fields[3] as double,
      price: fields[4] as String,
      location: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHotel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHotelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
