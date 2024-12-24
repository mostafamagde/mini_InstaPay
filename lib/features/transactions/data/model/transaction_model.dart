import 'package:untitled2/features/transactions/data/model/transaction_user_model.dart';

class TransactionModel {
  final String id;
  String status;
  final String type;
  final double amount;
  final TransactionUserModel sender;
  final TransactionUserModel receiver;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.status,
    required this.type,
    required this.amount,
    required this.sender,
    required this.receiver,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['_id'],
      status: json['status'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      sender: TransactionUserModel.fromJson(json['sender']),
      receiver: TransactionUserModel.fromJson(json['reciever']), // Corrected to match JSON key
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'type': type,
      'amount': amount,
      'sender': sender.toJson(),
      'reciever': receiver.toJson(), // Corrected to match JSON key
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, status: $status, type: $type, amount: $amount, '
        'sender: $sender, receiver: $receiver, createdAt: $createdAt)';
  }
}
