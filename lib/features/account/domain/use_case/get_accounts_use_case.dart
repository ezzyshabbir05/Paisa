import 'package:injectable/injectable.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/use_case/use_case.dart';
import 'package:paisa/features/account/domain/entities/account.dart';
import 'package:paisa/features/account/domain/repository/account_repository.dart';

@singleton
class GetAccountsUseCase extends UseCase<List<AccountEntity>, void> {
  GetAccountsUseCase({required this.accountRepository});

  final AccountRepository accountRepository;

  @override
  List<AccountEntity> call({void params}) {
    return accountRepository.getAccounts().toEntities();
  }
}