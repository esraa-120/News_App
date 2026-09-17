import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/models/category_model.dart';

class CategoryCardItem extends StatelessWidget {

  final int index;
  final CategoryModel categoryModel;
  const CategoryCardItem({super.key, required this.categoryModel, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: AssetImage(categoryModel.image),
        fit: BoxFit.cover
        )
      ),
      child: Directionality(
        textDirection: index % 2 == 0 ? TextDirection.rtl
        : TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryModel.name,
              style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white,
              fontSize: 25
              )
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(84)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 25, color: AppColors.mainText,)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                    child: Text(
                      "View All",
                      style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
