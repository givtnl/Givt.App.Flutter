import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class AddFaveOrgButton extends StatelessWidget {
  const AddFaveOrgButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle,
                size: 30,
                color: Palette.greyBlueTone,
              )),
          Text(
            'add another favorite church or charity',
            style: TextStyle(
              color: Palette.darkBlue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
