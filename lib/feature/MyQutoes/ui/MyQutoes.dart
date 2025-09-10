import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/MyQutoes/controller/my_quates.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';
import 'package:qutoes_app/feature/home/ui/widgets/category_tab.dart';

class MyQutoes extends StatelessWidget {
  const MyQutoes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyQuatesProvider>(
      create: (_) => MyQuatesProvider()..getQuotes(),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Consumer<MyQuatesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }
            return provider.quates.isEmpty
                ? Center(child: Text("لا يوجد اقتباسات"))
                : ListView.separated(
                    itemCount: provider.quates.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return CardQuotes(
                        qutoes: provider.quates[index]['content'],
                        category: provider.quates[index]['category'],
                        auther: "",
                        edit: provider.updateLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  final provider = Provider.of<MyQuatesProvider>(context, listen: false);

                                  // 2. قم بتحديد الـ Category المبدئي قبل فتح الـ Dialog
                                  int initialCategoryIndex = provider.updatepdateCategory.indexOf(
                                    provider.quates[index]['category'],
                                  );

                                  // 3. قم بتحديث الحالة هنا، مرة واحدة فقط قبل بناء أي شيء
                                  provider.toggleSelectedUpdateId(initialCategoryIndex);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController titleController = TextEditingController(
                                        text: provider.quates[index]['title'],
                                      );
                                      TextEditingController contentController = TextEditingController(
                                        text: provider.quates[index]['content'],
                                      );
                                      final formKey = GlobalKey<FormState>();
                                      return ChangeNotifierProvider.value(
                                        value: provider,
                                        child: Consumer<MyQuatesProvider>(
                                          builder: (context, provider2, child) {
                                            return AlertDialog(
                                              title: Text('تعديل الاقتباس'),
                                              content: Form(
                                                key: formKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'العنوان مطلوب';
                                                        }
                                                        return null;
                                                      },
                                                      controller: titleController,
                                                      decoration: InputDecoration(
                                                        hintText: 'العنوان',
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    TextFormField(
                                                      maxLines: 5,

                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'المحتوي مطلوب';
                                                        }
                                                        return null;
                                                      },
                                                      controller: contentController,
                                                      decoration: InputDecoration(
                                                        hintText: 'المحتوي',
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    Wrap(
                                                      children: provider2.updatepdateCategory.map((toElement) {
                                                        return CategoryTab(
                                                          title: toElement,
                                                          isSelected:
                                                              (provider2.selectedUpdateId ==
                                                              provider2.updatepdateCategory.indexOf(toElement)),
                                                          onTap: () async {
                                                            await provider2.toggleSelectedUpdateId(
                                                              provider2.updatepdateCategory.indexOf(toElement),
                                                            );
                                                            // provider2.selectedUpdateId = index;
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                    SizedBox(height: 12),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: ColorsApp.primary,
                                                          foregroundColor: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          print(contentController.text);
                                                          print(titleController.text);
                                                          print(provider.quates[index]['_id']);
                                                          if (formKey.currentState!.validate()) {
                                                            provider.updateQuote(
                                                              id: provider.quates[index]['_id'],
                                                              title: titleController.text,
                                                              content: contentController.text,
                                                              context: context,
                                                            );
                                                          }
                                                        },
                                                        child: Text('تعديل'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },

                                icon: Icon(Icons.edit),
                              ),
                        delete: provider.deleteLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  provider.deleteQuote(id: provider.quates[index]['_id'], context: context);
                                },
                                icon: Icon(Icons.delete),
                              ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
