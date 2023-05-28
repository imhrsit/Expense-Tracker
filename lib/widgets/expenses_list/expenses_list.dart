import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemovedExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(color: const Color.fromARGB(255, 212, 126, 121),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
            ),
            onDismissed: (direction) {
              onRemovedExpense(expenses[index]);
            },
            child: ExpenseItem(
              expense: expenses[index],
            ),
          );
        });
  }
}
