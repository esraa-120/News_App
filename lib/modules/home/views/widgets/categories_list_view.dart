// import 'package:flutter/material.dart';
//
// import 'category_card_item.dart';
//
// class CategoriesListView extends StatelessWidget {
//   const CategoriesListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         spacing: 16,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Good Morning\nHere is Some News For You",
//             style: theme.textTheme.headlineSmall,
//           ),
//           Expanded(
//             child: ListView.separated(
//               physics: ClampingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return CategoryCardItem(
//                   categoryModel: categories[index],
//                   index: index,
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return SizedBox(height: 16,);
//               },
//               itemCount: categories.length,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
