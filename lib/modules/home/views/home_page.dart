import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/main.dart';
import 'package:news_app/modules/home/views/widgets/category_card_item.dart';
import 'package:news_app/modules/home/views/widgets/drawer_builder_view.dart';
import 'package:news_app/modules/home/views/widgets/selected_category_view.dart';
import 'package:provider/provider.dart';

import '../view_model/home_view_model.dart';

class HomePage extends StatelessWidget {
 const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final local = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final vm = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          vm.selectedCategory == null ? local.home
           : vm.selectedCategory!.name ,
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
            vm.changeSelectedCategory(null);
            navigatorKey.currentState!.pop();
          },
        ),
      ),

      body: vm.selectedCategory == null ? Padding(
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
                        vm.changeSelectedCategory(vm.categories[index]);
                      },
                      child: CategoryCardItem(
                        categoryModel: vm.categories[index],
                        index: index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16,);
                  },
                  itemCount: vm.categories.length,
              ),
            )
          ],
        ),
      )
          : SelectedCategoryView(),
    );
  }
}
