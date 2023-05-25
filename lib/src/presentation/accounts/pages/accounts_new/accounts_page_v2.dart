import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../main.dart';
import '../../../../core/common.dart';
import '../../../../data/expense/model/expense_model.dart';
import '../../../../domain/account/entities/account.dart';
import '../../../../domain/expense/entities/expense.dart';
import '../../../widgets/paisa_empty_widget.dart';
import '../../widgets/account_card_v2.dart';

class AccountsPageV2 extends StatelessWidget {
  const AccountsPageV2({
    super.key,
    required this.accounts,
  });

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return EmptyWidget(
        icon: Icons.credit_card,
        title: context.loc.emptyAccountMessageTitle,
        description: context.loc.emptyAccountMessageSubTitle,
      );
    } else {
      return ValueListenableBuilder<Box<ExpenseModel>>(
        valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
        builder: (context, value, child) {
          return ScreenTypeLayout(
            mobile: ListView.builder(
              padding: const EdgeInsets.only(bottom: 124),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final List<Expense> expenses = value
                    .expensesFromAccountId(accounts[index].superId!)
                    .map((e) => e.toEntity())
                    .toList();
                return AccountCardV2(
                  account: accounts[index],
                  expenses: expenses,
                );
              },
            ),
            tablet: GridView.builder(
              padding: const EdgeInsets.only(bottom: 124),
              shrinkWrap: true,
              itemCount: accounts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final List<Expense> expenses = value
                    .expensesFromAccountId(accounts[index].superId!)
                    .map((e) => e.toEntity())
                    .toList();
                return AccountCardV2(
                  account: accounts[index],
                  expenses: expenses,
                );
              },
            ),
          );
        },
      );
    }
  }
}
