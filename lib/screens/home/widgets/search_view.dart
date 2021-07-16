// import 'package:flutter/material.dart';
//
// class SearchView extends StatelessWidget {
//   final ValueChanged onFilterData;
//   TextEditingController _textEditingController = TextEditingController();
//   SearchView({required this.onFilterData});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: TextField(
//         textInputAction: TextInputAction.search,
//         textAlignVertical: TextAlignVertical.center,
//         onSubmitted: onFilterData,
//         controller: _textEditingController,
//         decoration: InputDecoration(
//             fillColor: Colors.grey[200],
//             filled: true,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             prefixIcon: IconButton(
//               onPressed: () => onFilterData(_textEditingController.text),
//               icon: const Icon(Icons.search, color: Colors.blue, size: 30),
//             ),
//             suffixIcon: IconButton(
//               onPressed: () {
//                 _textEditingController.clear();
//                 FocusScope.of(context).unfocus();
//                 onFilterData('');
//               },
//               icon: const Icon(Icons.close, color: Colors.blue, size: 30),
//             ),
//             hintText: 'Search'),
//       ),
//     );
//   }
// }
