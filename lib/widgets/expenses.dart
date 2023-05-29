import 'dart:ffi';

import 'package:expence_tracker/widgets/chart/chart.dart';
import 'package:expence_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expence_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expense.dart';

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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      //isScrollControlled: true,
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

    Widget mainContent = const Center(
      child: Text('No expenses found. start adding!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemovedExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ) : Row(children: [
        Expanded(
          child: Chart(expenses: _registeredExpenses)
          ),
          Expanded(
            child: mainContent,
          ),
      ],),
    );
  }
}
