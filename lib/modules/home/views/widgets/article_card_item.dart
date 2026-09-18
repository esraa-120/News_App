import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/models/article_model.dart';


class ArticleCardItem extends StatelessWidget {

  final ArticleModel articleModel;
  const ArticleCardItem({super.key, required this.articleModel});

  @override
  Widget build(BuildContext context) {

    // final sourceList = snapshot.data ?? [];
    final theme = Theme.of(context);
    return Container(
      // height: 330,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: articleModel.urlToImage,
            imageBuilder: (context, imageProvider) => Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
              ),
            ),),
            placeholder: (context, url) => SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(child: Icon(Icons.error, size: 50,))),
          ),
          Text(
            articleModel.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "By: ${articleModel.author}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.secondaryText
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  articleModel.publishedAt,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryText),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
