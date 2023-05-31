import 'package:expence_tracker/screens/profile_page.dart';
import 'package:expence_tracker/widgets/chart/chart.dart';
import 'package:expence_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expence_tracker/screens/new_expense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expense.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Dominos',
        amount: 300,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Movie',
        amount: 800,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Metro',
        amount: 500,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'Books',
        amount: 600,
        date: DateTime.now(),
        category: Category.work),
  ];

  void _openAddExpenseOverlay(double height) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // isDismissible: true,
      useSafeArea: true,
      // enableDrag: true,
      anchorPoint: Offset(0, 60),
      constraints: BoxConstraints.loose(
        Size(double.infinity, height * 0.7),
      ),
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text('No expenses found. start adding!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemovedExpense: _removeExpense,
      );
    }

    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Expense Tracker'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(UserProfile.routeName),
                    icon:
                        const Icon(FontAwesomeIcons.solidCircleUser, size: 36),
                  ),
                ),
              ],
            ),
            body: width < 600
                ? Column(
                    children: [
                      Chart(expenses: _registeredExpenses),
                      Expanded(
                        child: mainContent,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: Chart(expenses: _registeredExpenses)),
                      Expanded(
                        child: mainContent,
                      ),
                    ],
                  ),
          ),
        ),
        Positioned(
          child: ElevatedButton(
            onPressed: () => _openAddExpenseOverlay(height),
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(10),
              backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary.withOpacity(0.65),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.wallet,
                    color: Theme.of(context).textTheme.titleLarge!.color),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Add Expense",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.titleLarge!.color),
                ),
              ],
            ),
          ),
          bottom: 40,
          right: 20,
        ),
      ],
    );
  }
}
