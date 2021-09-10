import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function onSubmit;
  final TextEditingController controller;
  const SearchWidget({
    Key? key,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: (value) {
          onSubmit(value);
        },
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: IconButton(
              onPressed: () => onSubmit(controller.text),
              icon: const Icon(Icons.search, color: Colors.blue, size: 30),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
                onSubmit('');
              },
              icon: const Icon(Icons.close, color: Colors.blue, size: 30),
            ),
            hintText: 'Search'),
      ),
    );
  }
}
