// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_prefs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingPrefsAdapter extends TypeAdapter<SettingPrefs> {
  @override
  final int typeId = 3;

  @override
  SettingPrefs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingPrefs(
      isBgMusicOn: fields[0] as bool,
      bgVolume: fields[1] as double,
      bgMatrixOn: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingPrefs obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isBgMusicOn)
      ..writeByte(1)
      ..write(obj.bgVolume)
      ..writeByte(2)
      ..write(obj.bgMatrixOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingPrefsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
