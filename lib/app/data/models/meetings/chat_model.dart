class Chat {
  final String? id;
  final DateTime time;
  final String senderId;
  final String receiverId;
  final String message;

  Chat(
      {this.id,
      required this.time,
      required this.senderId,
      required this.receiverId,
      required this.message});
}
