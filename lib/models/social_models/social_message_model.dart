class SocialMessageModel {
  late String senderId;
  late String receiverId;
  late String message;
  late String time;

  SocialMessageModel(
      {required this.senderId,
      required this.receiverId,
      required this.message,
      required this.time});

  SocialMessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }
}
