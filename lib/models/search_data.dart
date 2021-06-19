enum SearchedType { Bus, Stop }

class SearchData {
  String title;
  String subtitle;
  String description;
  SearchedType type;
  SearchData(
      {required this.title,
      required this.subtitle,
      required this.description,
      required this.type});
}
