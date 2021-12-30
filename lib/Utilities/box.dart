import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp/models/chat.dart';
import 'package:whatsapp/models/contactmodel.dart';
import 'package:whatsapp/models/message.dart';

Future<void> openMessageModelBox(String name) async {
  if (Hive.isBoxOpen(name)) {
  } else {
    await Hive.openBox<MessageModel>(name);
  }
}

Future<void> openChatModelBox() async {
  if (Hive.isBoxOpen('chats')) {
  } else {
    await Hive.openBox<ChatModel>('chats');
  }
}

Future<void> openContactModelBox() async {
  if (Hive.isBoxOpen('contacts')) {
  } else {
    await Hive.openBox<ContactModel>('contacts');
  }
}
