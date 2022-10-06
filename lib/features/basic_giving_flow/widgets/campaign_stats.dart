import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampaignStats extends StatelessWidget {
  final double days;
  final double currentMoney;
  final double goalMoney;

  CampaignStats({
    super.key,
    required this.currentMoney,
    required this.days,
    required this.goalMoney,
  });
  final currency = NumberFormat.currency(
    locale: "en_US",
    symbol: "\$",
    decimalDigits: 0,
  );

  // theres a better way of doing this one i bet
  final day = NumberFormat.currency(
    decimalDigits: 0,
    symbol: "",
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                            text: day.format(days).toString(),
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        const TextSpan(text: ' days left'),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.track_changes,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    RichText(
                      text: TextSpan(
                        text: ' ',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.w700),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${currency.format(currentMoney)}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          TextSpan(text: ' / '),
                          TextSpan(text: '${currency.format(goalMoney)}')
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
