// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelAdapter extends TypeAdapter<ChatModel> {
  @override
  final int typeId = 2;

  @override
  ChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModel(
      number: fields[0] as String,
      name: fields[1] as String,
      lastmessage: fields[2] as String,
      status: fields[4] as String,
      epoch: fields[5] as int,
      online: fields[6] as bool,
      last: fields[8] == null ? true : fields[8] as bool,
      seen: fields[7] as bool,
      time: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastmessage)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.epoch)
      ..writeByte(6)
      ..write(obj.online)
      ..writeByte(7)
      ..write(obj.seen)
      ..writeByte(8)
      ..write(obj.last);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
