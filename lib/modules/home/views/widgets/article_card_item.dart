import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';


class ArticleCardItem extends StatefulWidget {

  final ArticleModel articleModel;
  const ArticleCardItem({super.key, required this.articleModel});

  @override
  State<ArticleCardItem> createState() => _ArticleCardItemState();
}

class _ArticleCardItemState extends State<ArticleCardItem> {
  @override
  Widget build(BuildContext context) {

    // final sourceList = snapshot.data ?? [];
    final theme = Theme.of(context);
    return InkWell(
      onTap: (){
        _showArticleDetails(widget.articleModel);
      },
      child: Container(
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
              imageUrl: widget.articleModel.urlToImage,
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
              widget.articleModel.title,
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
                    "By: ${widget.articleModel.author}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryText
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    widget.articleModel.publishedAt,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
  void _showArticleDetails(ArticleModel articleModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.articleModel.urlToImage,
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
                    widget.articleModel.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FilledButton(onPressed: (){
                    launchUrl(Uri.parse(articleModel.url), mode: LaunchMode.inAppWebView);
                  } ,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.all(16),

                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text("View Full Article"))
                ],
              ),
            )
          ]
        )
    );
  }
}
