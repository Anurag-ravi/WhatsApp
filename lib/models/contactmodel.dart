class ContactModel {
  final String number;
  final String name;
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
