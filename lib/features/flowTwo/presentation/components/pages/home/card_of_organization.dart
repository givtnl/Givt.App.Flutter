import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/features/flowTwo/presentation/components/core/buttons/button_bar.dart';

class CardOrganization extends StatelessWidget {
  const CardOrganization({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'first church of Atlanta',
                    style: TextStyle(
                      color: Palette.darkBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_rounded,
                      size: 21,
                      color: Palette.brightPink,
                    ),
                  )
                ],
              ),
            ),
            const BarButton(
              title: "tithes and offerings",
            ),
            const BarButton(
              title: "building fund",
            ),
            const BarButton(
              title: "mission and development",
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'view everything from first church of Atlanta',
                style: TextStyle(
                  color: Palette.greyBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
