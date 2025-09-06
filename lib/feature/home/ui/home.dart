import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/home/controller/main_controller.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';
import 'package:qutoes_app/feature/home/ui/widgets/category_tab.dart';
import 'package:qutoes_app/feature/home/ui/widgets/main_nav.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => MainProvider()..getQuotes(),
        child: Scaffold(
          backgroundColor: ColorsApp.background,

          floatingActionButton: Consumer<MainProvider>(
            builder: (context, provider, child) {
              return FloatingActionButton(
                mini: true,
                shape: const CircleBorder(),
                key: UniqueKey(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Add Quote'),
                        content: Form(
                          key: provider.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: provider.addTitleQuotesController,
                                decoration: InputDecoration(hintText: 'Title'),
                              ),
                              TextFormField(
                                controller: provider.addContentQuotesController,
                                decoration: InputDecoration(hintText: 'Content'),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              await provider.addQuotes(context);
                              Navigator.pop(context);
                            },
                            child: Text('Add'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsApp.primary,
                              foregroundColor: ColorsApp.background,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: ColorsApp.primary,
                // shape: const CircleBorder(),
                elevation: 4,
                child: SvgPicture.asset('assets/images/edit.svg', width: 52, height: 52),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: Consumer<MainProvider>(
            key: UniqueKey(),
            builder: (context, provider, child) {
              return BottomNavigationBar(
                selectedLabelStyle: TextStyle(color: ColorsApp.primary),
                unselectedLabelStyle: TextStyle(color: ColorsApp.textSecondary),
                selectedItemColor: ColorsApp.primary,
                unselectedItemColor: ColorsApp.textSecondary,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: provider.items(context),
                currentIndex: provider.currentIndex,

                onTap: (index) {
                  provider.setCurrentIndex(index);
                },
              );
            },
          ),

          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 48),

            child: Consumer<MainProvider>(
              builder: (context, provider, child) {
                return provider.screens[provider.currentIndex];
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<String> categories = const ["الكل", "أدب", "فلسفة", "تحفيز", "حكم"];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اهلا بك مجددا", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsApp.textPrimary)),
            SizedBox(height: 8),
            Text("اقرا شارك والهم ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsApp.textSecondary)),
            SizedBox(height: 24),
            SearchBar(
              controller: provider.searchQuotesController,
              hintText: 'ابحث عن اقتباس',
              onChanged: (value) {
                provider.searchQuates();
              },
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTab(title: categories[index], isSelected: index == 0, onTap: () {});
                },
              ),
            ),
            SizedBox(height: 16),
            Consumer<MainProvider>(
              builder: (context, provider, child) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemCount: provider.searchQuotesController.text.isEmpty
                        ? provider.quotes.length
                        : provider.quatesResult.length,
                    itemBuilder: (context, index) {
                      return CardQuotes(
                        qutoes: provider.searchQuotesController.text.isEmpty
                            ? provider.quotes[index]['content']
                            : provider.quatesResult[index]['content'],
                        auther: provider.searchQuotesController.text.isEmpty
                            ? provider.quotes[index]['user']
                            : provider.quatesResult[index]['user'],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
