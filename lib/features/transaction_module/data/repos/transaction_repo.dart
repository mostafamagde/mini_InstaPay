import 'package:dartz/dartz.dart';
import 'package:untitled2/core/errors/errors.dart';

import '../models/send_model.dart';

abstract class TransactionRepo {
  Future<Either<Errors,String>>sendMoney(SendModel send);
}