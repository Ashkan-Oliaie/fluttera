// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEntryAdapter extends TypeAdapter<HiveEntry> {
  @override
  final int typeId = 0;

  @override
  HiveEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEntry(
      name: fields[0] as String,
      entry: (fields[1] as List)?.cast<HiveRecord>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.entry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveRecordAdapter extends TypeAdapter<HiveRecord> {
  @override
  final int typeId = 1;

  @override
  HiveRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveRecord(
      field: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.field)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
