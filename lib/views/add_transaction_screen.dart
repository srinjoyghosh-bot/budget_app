import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/size_config.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);
  static const String id = '/add';

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _key = GlobalKey<FormState>();
  String title = '', amount = '';
  TransactionCategory selectedCategory = TransactionCategory.miscellaneous;
  TransactionType selectedType = TransactionType.spent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Add Transaction'),
          backgroundColor: brandColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical * 2)
              .copyWith(bottom: 0),
          child: Form(
              key: _key,
              child: Column(
                children: [
                  const Spacer(),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.black.withOpacity(0.65)),
                      labelText: 'Title',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      title = value!.trim();
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelStyle:
                          TextStyle(color: Colors.black.withOpacity(0.65)),
                      labelText: 'Amount',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      amount = value!.trim();
                    },
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  DropdownButtonFormField(
                    // focusColor: Colors.black,
                    items: const [
                      DropdownMenuItem(
                        value: TransactionCategory.clothes,
                        child: Text('Clothes'),
                      ),
                      DropdownMenuItem(
                        value: TransactionCategory.food,
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: TransactionCategory.travel,
                        child: Text('Travel'),
                      ),
                      DropdownMenuItem(
                        value: TransactionCategory.miscellaneous,
                        child: Text('Miscellaneous'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value is TransactionCategory) {
                        selectedCategory = value;
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Choose a complain type';
                      }
                      return null;
                    },
                    hint: const Text('Select a category'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(
                        value: TransactionType.spent,
                        child: Text('Money Spent'),
                      ),
                      DropdownMenuItem(
                        value: TransactionType.receive,
                        child: Text('Money Received'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value is TransactionType) {
                        selectedType = value;
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Choose a transaction type';
                      }
                      return null;
                    },
                    hint: const Text('Select a transaction type'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: brandColor,
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
