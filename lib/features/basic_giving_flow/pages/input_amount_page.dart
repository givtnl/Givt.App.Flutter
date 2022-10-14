import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/input_controller.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_info.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/campaign_stats.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/donation_template.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/input_button_donation.dart';

class DoantionAmountInput extends StatefulWidget {
  DoantionAmountInput({super.key});

  @override
  State<DoantionAmountInput> createState() => _DoantionAmountInputState();
}

class _DoantionAmountInputState extends State<DoantionAmountInput> {
// should be received from QR scan, gotten from database, etc
  Map<String, dynamic> FetchedInfo = {
    'mediumId': 'medium-receieved-from-qr',
  };
  // for user input
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // exit the keyboard when clicking outside of it.
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: DoantionTemplate(
        questionText: 'How much would you like to donate?',
        content: InputButton(
          child: TextField(
            autofocus: true,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
            decoration: InputDecoration(
              // none of these show up wtf...
              hoverColor: Colors.red,
              focusColor: Colors.green,
              fillColor: Colors.yellow,
              // up to here

              prefix: Text(
                '\$',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
              ),
              focusedBorder:
                  const UnderlineInputBorder(borderSide: BorderSide(width: 0)),
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) {
              InputController(context).handleSubmit(
                  _amountController.text, FetchedInfo['mediumId']);
            },
          ),
        ),
      ),
    );
  }
}