// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 1;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[0] as String,
      hotelId: fields[1] as String,
      hotelName: fields[2] as String,
      imageUrl: fields[3] as String,
      checkIn: fields[4] as DateTime,
      checkOut: fields[5] as DateTime,
      guests: fields[6] as int,
      totalPrice: fields[7] as double,
      status: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hotelId)
      ..writeByte(2)
      ..write(obj.hotelName)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.checkIn)
      ..writeByte(5)
      ..write(obj.checkOut)
      ..writeByte(6)
      ..write(obj.guests)
      ..writeByte(7)
      ..write(obj.totalPrice)
      ..writeByte(8)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
