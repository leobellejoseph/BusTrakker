import 'package:flutter/material.dart';

import 'widgets.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.black45),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Favorites',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            FavoritesList(),
          ],
        ),
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return SliverToBoxAdapter(
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         border: Border.all(color: Colors.black45),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Text(
//               'Favorites',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 color: Colors.blue,
//               ),
//             ),
//             FavoritesList(),
//           ],
//         ),
//       ),
//     ),
//   );
// }
