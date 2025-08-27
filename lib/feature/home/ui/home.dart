import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/theme/colors.dart';
import 'package:qutoes_app/feature/home/ui/widgets/card_quotes.dart';
import 'package:qutoes_app/feature/home/ui/widgets/category_tab.dart';
import 'package:qutoes_app/feature/home/ui/widgets/main_nav.dart';

class Home extends StatelessWidget {
  final List<String> categories = const [
    "الكل",
    "أدب",
    "فلسفة",
    "تحفيز",
    "حكم",
  ];
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.background,
       
         floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/AddQuoteScreen');
          },
          backgroundColor: ColorsApp.primary, 
          shape: const CircleBorder(),
          elevation: 4,
          child: SvgPicture.asset(
            'assets/images/edit.svg',
            width: 52,
            height: 52,
            // لو بدك تغيّري لون الأيقونة:
          //  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        body:Padding(
          padding: const EdgeInsets.only(
            left: 16, right: 16,top:48 ),
            
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اهلا بك مجددا",
                  style: Theme.of(context).textTheme.bodyLarge?.
                  copyWith(color: ColorsApp.textPrimary),
                ),
                SizedBox(height: 8,),
               Text(
                "اقرا شارك والهم "  ,
                  style: Theme.of(context).textTheme.bodyLarge?.
                  copyWith(color: ColorsApp.textSecondary),
                ),
                SizedBox(height: 24,),
                SearchBar(
                  controller: TextEditingController(),

                  onChanged: (value) {
                  
                  },
                ),
                SizedBox(height: 24,),
               SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTab(
                      title: categories[index],
                      isSelected: index == 0,
                      onTap: () {
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16,),
              CardQuotes(
                qutoes: "لا تحزن ان الله معنا",
                 auther: "محمد صلى الله عليه وسلم",),
                   CardQuotes(
                qutoes: " بنفسك وابدا الان لا تنتظر الفرص بل اصنعها",
                 auther: "اية عادل ",),
                   CardQuotes(
                qutoes: " النجاح هو ان تؤمن بنفسك عندما يشك الجميع بك ",
                 auther: "ندى ايهاب ",)

            ],
          ),
        ),
      ),
    );
  }
}

