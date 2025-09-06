import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';

class CardQuotes extends StatelessWidget {
  final String qutoes;
  final String auther;
  const CardQuotes({super.key, required this.qutoes, required this.auther});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(qutoes, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorsApp.textPrimary)),

              Text(auther, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorsApp.textSecondary)),
            ],
          ),
          Spacer(),
          Column(children: [SvgPicture.asset('assets/images/heart.svg')]),
        ],
      ),
    );
  }
}
