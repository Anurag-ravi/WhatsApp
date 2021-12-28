import 'package:hive/hive.dart';

part 'contactmodel.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  ContactModel(
      {required this.number, required this.name, required this.status});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      number: json['_id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
