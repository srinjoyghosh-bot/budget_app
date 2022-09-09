import 'package:budget_app/constants/enums.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/util/toasts.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class EditBudgetScreen extends StatefulWidget {
  const EditBudgetScreen({Key? key}) : super(key: key);
  static const String id = '/budget';

  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  final TextEditingController _controller = TextEditingController();
  late MainViewModel _model;

  void submit() async {
    final text = _controller.text;
    if (text.trim().isEmpty) {
      showWarningToast('Give a budget', context);
      return;
    } else if (double.tryParse(_controller.text) == null) {
      showWarningToast('Please enter a number', context);
      return;
    }
    final result = await _model.updatedBudget(_controller.text.trim());
    if (result) {
      Navigator.of(context).pop();
      showSuccessToast('Budget updated', context);
    } else {
      showErrorToast(_model.errorMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Set Monthly Budget',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 3),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: brandColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              ElevatedButton(
                  onPressed: () {
                    if (_model.state == ViewState.idle) {
                      submit();
                    }
                  },
                  child: _model.state == ViewState.idle
                      ? Text(
                          'SAVE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 2.5),
                        )
                      : SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
