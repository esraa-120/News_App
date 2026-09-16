import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/modules/home/pages/widgets/category_card_item.dart';
import 'package:news_app/modules/home/pages/widgets/drawer_builder_view.dart';
import 'package:news_app/modules/home/pages/widgets/selected_category_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<CategoryModel> _categories = [
    CategoryModel(id: 'general', name: 'General', image: Assets.images.general.path),
    CategoryModel(id: 'business', name: 'Business', image: Assets.images.busniess.path),
    CategoryModel(id: 'sports', name: 'Sports', image: Assets.images.sport.path),
    CategoryModel(id: 'technology', name: 'Technology', image: Assets.images.technology.path),
    CategoryModel(id: 'entertainment', name: 'Entertainment', image: Assets.images.entertainment.path),
    CategoryModel(id: 'health', name: 'Health', image: Assets.images.helth.path),
    CategoryModel(id: 'science', name: 'Science', image: Assets.images.science.path),
  ];

  CategoryModel? _selectCategory;

  @override
  Widget build(BuildContext context) {

    final local = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          _selectCategory == null ? local.home
           : _selectCategory!.name ,
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Assets.icons.searchIcn.svg(),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.mainText,
        child: DrawerBuilderView(
          goToHome: (){
            setState(() {
              _selectCategory = null;
            });
            navigatorKey.currentState!.pop();
          },
        ),
      ),

      body: _selectCategory == null ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local.good_morning,
              style: theme.textTheme.headlineSmall,
             ),
            Expanded(
              child: ListView.separated(
                physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _selectCategory = _categories[index];
                        setState(() {});
                      },
                      child: CategoryCardItem(
                        categoryModel: _categories[index],
                        index: index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16,);
                  },
                  itemCount: _categories.length,
              ),
            )
          ],
        ),
      )
          : SelectedCategoryView(
        selectedCategoryModel: _selectCategory!,
      ),
    );
  }
}
