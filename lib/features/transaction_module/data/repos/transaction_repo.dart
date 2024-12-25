import 'package:dartz/dartz.dart';
import 'package:mini_instapay/core/errors/errors.dart';
import 'package:mini_instapay/features/transaction_module/data/models/receive_model.dart';
import 'package:mini_instapay/features/transaction_module/data/models/send_model.dart';

abstract class TransactionRepo {
  Future<Either<Errors, String>> sendMoney(SendModel send);
  Future<Either<Errors, String>> receiveMoney(ReceiveModel receive);
}
