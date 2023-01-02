import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/models/local_storage.dart';

class ChildCard extends StatelessWidget {
  ChildUser childInfo;
  ChildCard({required this.childInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.fromLTRB(25, 20, 10, 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Theme.of(context).canvasColor,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  childInfo.childName,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 15),
                ),
                Text(
                  'Balance: \$5',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
                Text(
                  'Last donation:--',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Theme.of(context).colorScheme.surface),
                ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0,
                //       backgroundColor: Theme.of(context).colorScheme.surface,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: const Text('Go to Givt Kids')),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: SvgPicture.asset('assets/svg/exit.svg', height: 16),
                  label: Text('Go to Givt Kids'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
