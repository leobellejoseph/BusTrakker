import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final ValueChanged onFilterData;
  final Function onRefreshData;
  SearchView({
    required this.textEditingController,
    required this.focusNode,
    required this.onFilterData,
    required this.onRefreshData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: onFilterData,
        focusNode: focusNode,
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: IconButton(
              onPressed: () => onFilterData,
              icon: const Icon(Icons.search, color: Colors.blue, size: 30),
            ),
            suffixIcon: IconButton(
              onPressed: () => onRefreshData,
              icon: const Icon(Icons.close, color: Colors.blue, size: 30),
            ),
            hintText: 'Search'),
      ),
    );
  }
}
