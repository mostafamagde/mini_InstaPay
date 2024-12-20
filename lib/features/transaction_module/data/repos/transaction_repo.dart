import 'package:dartz/dartz.dart';
import 'package:untitled2/core/errors/errors.dart';
import 'package:untitled2/features/transaction_module/data/models/receive_model.dart';
import 'package:untitled2/features/transaction_module/data/models/send_model.dart';

abstract class TransactionRepo {
  Future<Either<Errors, String>> sendMoney(SendModel send);
  Future<Either<Errors, String>> receiveMoney(ReceiveModel receive);
}
