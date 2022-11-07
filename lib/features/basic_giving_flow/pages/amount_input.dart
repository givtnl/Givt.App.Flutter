import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/donation_template.dart';
import 'package:givt_mobile_apps/core/widgets/buttons/generic_button.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/controller/amount_input.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/widgets/input_button_donation.dart';
import 'package:provider/provider.dart';

import '../../../models/organisation.dart';

class DoantionAmountInput extends StatefulWidget {
  const DoantionAmountInput({super.key});

  @override
  State<DoantionAmountInput> createState() => _DoantionAmountInputState();
}

class _DoantionAmountInputState extends State<DoantionAmountInput> {
  final _amountController = TextEditingController();
  bool isLoading = false;
  void toggleLoader(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final organisationProvider =
        Provider.of<Organisation>(context, listen: false);
    String decodedMediumId =
        utf8.decode(base64.decode(organisationProvider.mediumId!));
    return GestureDetector(
      // exit the keyboard when clicking outside of it.
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: DonationTemplate(
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
              // none of these ever show up the hell...
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
                  _amountController.text, decodedMediumId, toggleLoader);
            },
          ),
        ),
        button: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : GenericButton(
                text: 'Next',
                disabled: false,
                onClicked: () {
                  InputController(context).handleSubmit(
                      _amountController.text, decodedMediumId, toggleLoader);
                }),
      ),
    );
  }
}
