import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/core/widgets/appbar.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';
import 'package:qutoes_app/feature/loves/controller/fav_controller.dart';

class Loves extends StatelessWidget {
  const Loves({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavController>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text("أجمالي الاعجابات :${provider.allfavoriteQuotes.length}"),
              ),
            ),
            SizedBox(height: 12),
            if (provider.allfavoriteQuotes.isEmpty)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: Text("لا يوجد اعجابات"))],
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: provider.allfavoriteQuotes.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return CardQuotes(
                      qutoes: provider.allfavoriteQuotes[index]['content'],
                      auther: provider.allfavoriteQuotes[index]['user']['name'],
                      category: provider.allfavoriteQuotes[index]['category'],
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
