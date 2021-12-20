// ignore_for_file: empty_constructor_bodies, file_names

class ChatModel {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool isGroup;

  ChatModel(
      {required this.id,
      required this.name,
      required this.message,
      required this.time,
      required this.avatar,
      required this.isGroup});
}

List<ChatModel> chatdata = [
  ChatModel(
      id: '1',
      name: 'Anurag',
      message: 'how u doing!',
      time: '10:20',
      avatar: 'images/1.jpg',
      isGroup: false),
  ChatModel(
      id: '2',
      name: 'Pratik',
      message: 'not Doing!',
      time: '10:10',
      avatar: '',
      isGroup: false),
  ChatModel(
      id: '3',
      name: 'Pk',
      message: 'Why not Doing!',
      time: '10:05',
      avatar: 'images/3.jpg',
      isGroup: false),
  ChatModel(
      id: '4',
      name: 'Kalhapure',
      message: "It's his choice!",
      time: '10:00',
      avatar: 'images/4.jpg',
      isGroup: false),
  ChatModel(
      id: '5',
      name: 'Nandan',
      message: 'Well Said!',
      time: '09:58',
      avatar: '',
      isGroup: false),
  ChatModel(
      id: '6',
      name: 'Sweta',
      message: '😂😂😂',
      time: '09:50',
      avatar: 'images/6.jpg',
      isGroup: false),
  ChatModel(
      id: '7',
      name: 'Veer',
      message: 'Re Bete Mauj Krdi!',
      time: '09:46',
      avatar: 'images/7.jpg',
      isGroup: false),
  ChatModel(
      id: '8',
      name: 'Shruti',
      message: 'bde log',
      time: '09:31',
      avatar: 'images/8.jpg',
      isGroup: false),
  ChatModel(
      id: '9',
      name: 'CFF',
      message: 'Anurag:hehe',
      time: '09:29',
      avatar: '',
      isGroup: true),
  ChatModel(
      id: '10',
      name: 'Shubham',
      message: 'Bhai haw dekh',
      time: '09:29',
      avatar: 'images/10.jpg',
      isGroup: false),
  ChatModel(
      id: '11',
      name: 'Dura',
      message: 'Yaar party dedo',
      time: '09:27',
      avatar: 'images/11.jpg',
      isGroup: false),
  ChatModel(
      id: '12',
      name: 'Buudhsen',
      message: 'Niche mt ja',
      time: '09:26',
      avatar: 'images/12.jpg',
      isGroup: false),
  ChatModel(
      id: '13',
      name: 'Amit',
      message: 'Bola na niche mt ja',
      time: '09:25',
      avatar: 'images/13.jpg',
      isGroup: false),
  ChatModel(
      id: '14',
      name: 'Dak RR Fun Group',
      message: 'Bas yhi tk tha jo tha!',
      time: '09:23',
      avatar: '',
      isGroup: true),
];
