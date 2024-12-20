class TransactionModel {
  final String id;
  final String status;
  final String type;
  final double amount;
  final User sender;
  final User receiver;
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
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['reciever']), // Corrected to match JSON key
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

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String userName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      userName: json['userName'], // Added userName field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userName': userName, // Added userName field
    };
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, email: $email, userName: $userName)';
  }
}