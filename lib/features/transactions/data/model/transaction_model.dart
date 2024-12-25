import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/core/enums/transaction_type_enum.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_user_model.dart';

class TransactionModel {
  final String id;
  TransactionStatus status;
  final TransactionType type;
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
      status: TransactionStatus.fromJson(json['status']),
      type: TransactionType.fromJson(json['type']),
      amount: (json['amount'] as num).toDouble(),
      sender: TransactionUserModel.fromJson(json['sender']),
      receiver: TransactionUserModel.fromJson(json['reciever']), // Corrected to match JSON key
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status.value,
      'type': type.value,
      'amount': amount,
      'sender': sender.toJson(),
      'reciever': receiver.toJson(), // Corrected to match JSON key
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, status: ${status.value}, type: ${type.value}, amount: $amount, '
        'sender: $sender, receiver: $receiver, createdAt: $createdAt)';
  }
}
