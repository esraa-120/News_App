
import 'package:flutter/material.dart';
import 'package:news_app/core/network/http_requests_service.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/modules/home/views/widgets/article_card_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ArticleModel> articles = [];
  String? errorMessage;
  int maxResults = 0;
  int currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (articles.length < maxResults && searchController.text.isNotEmpty) {
          _search(searchController.text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            leading: SizedBox.shrink(),
            floating: true,
            leadingWidth: 0,
            title: TextFormField(
              controller: searchController,
              onFieldSubmitted: (value) {
                currentPage = 1;
                maxResults = 0;
                _search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.mainText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.searchIcn.svg(),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    }, 
                  icon: Icon(Icons.close),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.mainText,
                    width: 1,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.mainText,
                    width: 1,
                  ),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.mainText,
                  ),
                ),
              ),
            ),
          ),
          if(articles.isEmpty && errorMessage == null)
            SliverToBoxAdapter(
                child: Center(
                  child: Text("There are no articles"),
                )),
          if(errorMessage != null)
            SliverToBoxAdapter(
                child: Text(errorMessage!,
                  style: Theme.of(context).textTheme.titleMedium,
                )),
          if(articles.isNotEmpty)
            SliverList.separated(
                itemCount: articles.length < maxResults
                    ? articles.length + 1
                    : articles.length,
              itemBuilder: (context, index) {
                  if (index == articles.length) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                } else {
              return ArticleCardItem(articleModel: articles[index]);
            }
                  },
                separatorBuilder: (context, index) => SizedBox(height: 20,),)
        ]
      )
    );
  }

  void _search(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      errorMessage = null;
    });

    try {
      final response = await HttpRequestsService.searchArticles(
        searchQuery: query.trim(),
        pageNumber: currentPage,
      );
      currentPage++;
      maxResults += response.length;
      setState(() {
        articles = response;
      });
    } catch (e) {
      setState(() {
        articles = [];
        errorMessage = e.toString();
      });
    }
  }
}

