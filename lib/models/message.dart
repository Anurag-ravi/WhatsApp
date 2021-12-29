import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 3)
class MessageModel {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final bool own;

  @HiveField(2)
  final int epoch;

  MessageModel({required this.message, required this.own, required this.epoch});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      own: false,
      epoch: json['time'],
    );
  }
}
