import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_button.dart';
import 'package:intl/intl.dart';

class AmountInput extends StatefulWidget {
  @override
  State<AmountInput> createState() => _AmountInputState();
}

// has to be stateful for Navigator.of(context).pop line 27
class _AmountInputState extends State<AmountInput> {
  final _amountController = TextEditingController();

// this should store it in realm
// this void should be a separate controller
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 1.5) {
      // should say the minimum amount is 1.5
      return;
    }

// widget has to be stateful
    Navigator.of(context).pop(); // closes the top most screen sheet
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
              decoration: InputDecoration(
                labelText: 'How much would you like to donate?',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.w800),
                suffix: Text(
                  '\$',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            DonationButton(onPressed: () {}, label: 'Submit Amount'),
          ],
        ),
      ),
    );
  }
}
