import 'package:flutter/material.dart';
import 'package:news_app/modules/home/view_model/home_view_model.dart';
import 'package:news_app/modules/home/views/widgets/tab_bar_item.dart';
import 'package:provider/provider.dart';

import 'article_card_item.dart';

class SelectedCategoryView extends StatefulWidget {
  const SelectedCategoryView({super.key});

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.wait([
      Provider.of<HomeViewModel>(context, listen: false).getAllSources(),
    ]).then((value) {
      Provider.of<HomeViewModel>(context, listen: false).getAllArticles();
    });
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<HomeViewModel>(context);

    return Column(
      spacing: 16,
      children: [
        if(vm.sourcesList.isEmpty) Center(child: CircularProgressIndicator(),),
        if(vm.sourcesList.isNotEmpty)
        DefaultTabController(
          length: vm.sourcesList.length,
          child: TabBar(
            isScrollable: true,
            dividerHeight: 0,
            indicatorColor: Colors.black,
            labelPadding: EdgeInsets.symmetric(horizontal: 14),
            tabAlignment: TabAlignment.start,
            onTap: vm.changeTabIndex,
            tabs: vm.sourcesList
                .map(
                  (source) => TabBarItem(
                sourceModel: source,
                isSelected:
                vm.sourcesList.indexOf(source) == vm.selectedIndex,
              ),
            )
                .toList(),
          ),
        ),

        Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: vm.articlesList.length,
                itemBuilder: (context, index) {
                  return ArticleCardItem(
                    articleModel: vm.articlesList[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16)
            )
        ),
      ],
    );
  }
}
