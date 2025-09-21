import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/di.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/home/controller/main_controller.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';
import 'package:qutoes_app/feature/home/ui/widgets/category_tab.dart';
import 'package:qutoes_app/feature/loves/controller/fav_controller.dart';
import 'package:qutoes_app/feature/profile/controller/profile_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ServiceLocator.getIt<MainProvider>()..getQuotes()),
        ChangeNotifierProvider.value(value: ServiceLocator.getIt<FavController>()..getInitialFavQuotes()),
        ChangeNotifierProvider.value(value: ServiceLocator.getIt<ProfileController>()..getUser()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.primary,
          foregroundColor: Colors.white,
          title: Consumer<MainProvider>(
            builder: (context, provider, child) {
              return Text(tr(provider.titles[provider.currentIndex]));
            },
          ),
        ),
        backgroundColor: ColorsApp.background,
        floatingActionButton: Consumer<MainProvider>(
          builder: (context, provider, child) {
            return FloatingActionButton(
              mini: false,
              shape: const CircleBorder(),
              key: UniqueKey(),
              onPressed: () {
                addQoutesMethod(context, provider);
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
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),

          child: Consumer<MainProvider>(
            builder: (context, provider, child) {
              return provider.screens[provider.currentIndex];
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> addQoutesMethod(BuildContext context, MainProvider provider) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(tr("add quotes")),
          content: ChangeNotifierProvider.value(
            value: provider,
            child: Consumer<MainProvider>(
              builder: (context, provider2, child) {
                return Form(
                  key: provider2.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: provider.addTitleQuotesController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("title_required");
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: tr("title"), border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("content_required");
                          }
                          return null;
                        },
                        controller: provider.addContentQuotesController,
                        decoration: InputDecoration(hintText: tr("content"), border: OutlineInputBorder()),
                        maxLines: 5,
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        children: provider2.category.map((toElement) {
                          return GestureDetector(
                            onTap: () {
                              provider2.toggleSelectionCategory(toElement);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                              decoration: BoxDecoration(
                                color: provider2.selectedCategory == toElement
                                    ? ColorsApp.primary
                                    : ColorsApp.textSecondary.withOpacity(.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tr(toElement),
                                style: TextStyle(
                                  color: provider2.selectedCategory == toElement ? Colors.white : ColorsApp.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () async {
                if (provider.formKey.currentState!.validate()) {
                  await provider.addQuotes(context);
                  ServiceLocator.getIt<FavController>().getInitialFavQuotes();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.primary,
                foregroundColor: ColorsApp.background,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(tr("add")),
            ),
          ],
        );
      },
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
            Text(tr("welcome"), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsApp.textPrimary)),
            SizedBox(height: 8),
            Text(tr("read"), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorsApp.textSecondary)),

            Consumer<MainProvider>(
              builder: (context, provider, child) {
                if (provider.getQuotesLoading) {
                  return Expanded(child: Center(child: CircularProgressIndicator()));
                } else if (provider.errorMessage != null) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(provider.errorMessage!)),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            provider.getQuotes();
                          },
                          child: Text(tr("try_again")),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        SearchBar(
                          controller: provider.searchQuotesController,
                          hintText: tr('search'),
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
                              return CategoryTab(
                                title: tr(categories[index]),
                                isSelected: index == provider.selectedCategoryHome,
                                onTap: () {
                                  provider.toggleSelectionCategoryHome(index);
                                  provider.searchQuates(category: categories[index]);
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: provider.quotes.isEmpty
                              ? Center(child: Text(tr("no_Qoutes")))
                              : Consumer<FavController>(
                                  builder: (context, fave, child) {
                                    // تم تغيير اسم المتغير fave إلى provider ليكون أوضح
                                    // نستخدم الآن القائمة الموحدة
                                    final currentList = provider.displayedQuotes;

                                    return ListView.separated(
                                      separatorBuilder: (context, index) => SizedBox(height: 16),

                                      // itemCount أصبح بسيطًا جدًا
                                      itemCount: currentList.length,

                                      itemBuilder: (context, index) {
                                        // نصل إلى العنصر الحالي من القائمة الموحدة
                                        final quote = currentList[index];

                                        return CardQuotes(
                                          edit: IconButton(
                                            onPressed: () {
                                              // استخدم quote['_id'] للوصول إلى المعرف
                                              fave.toggleFavorite(quote['_id'], context);
                                            },
                                            icon: fave.isFavorite(quote['_id'])
                                                ? Icon(Icons.favorite, color: Colors.red)
                                                : Icon(Icons.favorite_border),
                                          ),
                                          // كل البيانات تأتي الآن من نفس المصدر الموحد 'quote'
                                          qutoes: quote['content'],
                                          auther: quote['user']['name'],
                                          category: quote['category'],
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
