import 'package:hive/hive.dart';

part 'chat.g.dart';

@HiveType(typeId: 2)
class ChatModel {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String lastmessage;

  @HiveField(3)
  final String time;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final int epoch;

  @HiveField(6)
  final bool online;

  @HiveField(7)
  final bool seen;

  @HiveField(8, defaultValue: true)
  final bool last;

  ChatModel(
      {required this.number,
      required this.name,
      required this.lastmessage,
      required this.status,
      required this.epoch,
      required this.online,
      required this.last,
      required this.seen,
      required this.time});
}
