class NotificationModel {
  final String id;
  final String content;
  final String userId;
  final String type;
  final String transactionId;
   bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.type,
    required this.transactionId,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      content: json['content'],
      userId: json['userId'],
      type: json['type'],
      transactionId: json['transactionId'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'userId': userId,
      'type': type,
      'transactionId': transactionId,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, content: $content, userId: $userId, type: $type, '
        'transactionId: $transactionId, isRead: $isRead, createdAt: $createdAt)';
  }
}
