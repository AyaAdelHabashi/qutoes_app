import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/MyQutoes/controller/my_quates.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';

class MyQutoes extends StatelessWidget {
  const MyQutoes({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<MyQuatesProvider>(
        create: (_) => MyQuatesProvider()..getQuotes(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Scaffold(
            backgroundColor: ColorsApp.background,
            body: Consumer<MyQuatesProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.errorMessage != null) {
                  return Center(child: Text(provider.errorMessage!));
                }
                return ListView.separated(
                  itemCount: provider.quates.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemBuilder: (context, index) {
                    return CardQuotes(
                      qutoes: provider.quates[index]['content'],
                      auther: provider.quates[index]['user'],
                      edit: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      delete: IconButton(
                        onPressed: () {
                          provider.deleteQuote(provider.quates[index]['_id']);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
