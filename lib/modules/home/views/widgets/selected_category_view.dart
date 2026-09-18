import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/modules/home/articles_cubit/articles_cubit.dart';
import 'package:news_app/modules/home/articles_cubit/articles_states.dart';
import 'package:news_app/modules/home/sources_cubit/sources_cubit.dart';
import 'package:news_app/modules/home/sources_cubit/sources_states.dart';
import 'package:news_app/modules/home/views/widgets/tab_bar_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'article_card_item.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryModel selectedCategoryModel;

  const SelectedCategoryView({super.key, required this.selectedCategoryModel});

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SourcesCubit>(
          create: (context) =>
              SourcesCubit()..getAllSources(widget.selectedCategoryModel.id),
        ),
        BlocProvider<ArticlesCubit>(create: (context) => ArticlesCubit()),
      ],
      child: Column(
        spacing: 20,
        children: [
          BlocConsumer<SourcesCubit, SourcesStates>(
            listener: (context, state) {
              if (state is SuccessGetAllSources) {
                /// Get All Articles
                context.read<ArticlesCubit>().getAllArticles(
                  state.sourcesList[selectedIndex].id,
                );
              }
            },
            builder: (context, state) {
              switch (state) {
                case LoadingGetAllSources():
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Skeletonizer(
                      child: Bone(
                        width: double.infinity,
                        height: 50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );

                case SuccessGetAllSources():
                  return DefaultTabController(
                    length: state.sourcesList.length,
                    child: TabBar(
                      isScrollable: true,
                      dividerHeight: 0,
                      indicatorColor: Colors.black,
                      labelPadding: EdgeInsets.symmetric(horizontal: 14),
                      tabAlignment: TabAlignment.start,
                      onTap: (value) {
                        setState(() {
                          selectedIndex = value;
                          context.read<ArticlesCubit>().getAllArticles(
                            state.sourcesList[selectedIndex].id,
                          );
                        });
                      },
                      tabs: state.sourcesList
                          .map(
                            (source) => TabBarItem(
                              sourceModel: source,
                              isSelected:
                                  state.sourcesList.indexOf(source) ==
                                  selectedIndex,
                            ),
                          )
                          .toList(),
                    ),
                  );

                case ErrorGetAllSources():
                  return Text(state.errorMessage);
              }
            },
          ),
          BlocBuilder<ArticlesCubit, ArticlesStates>(
            builder: (context, state) {
              switch (state) {
                case LoadingGetAllArticles():
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          child: Bone(
                            width: double.infinity,
                            height: 200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                    ),
                  );

                case SuccessGetAllArticles():
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.articlesList.length,
                      itemBuilder: (context, index) {
                        return ArticleCardItem(
                          articleModel: state.articlesList[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                    ),
                  );

                case ErrorGetAllArticles():
                  return Text(state.errorMessage);
              }
            },
          ),
        ],
      ),
    );
  }
}
