import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';

abstract class TransactionRepository {
  //store transaction to remote db
  Future<dynamic> storeTransaction({required TransactionModel transaction});
}
