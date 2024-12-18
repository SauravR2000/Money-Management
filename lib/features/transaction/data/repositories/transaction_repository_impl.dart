import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:money_management_app/main.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final database = supabase.from('Transaction');

  @override
  Future storeTransaction({required TransactionModel transaction}) async {
    return await database.insert(transaction.toJson());
  }
}
