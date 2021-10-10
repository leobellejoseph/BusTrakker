import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String caption;
  final Function onTap;
  final bool showButton;
  const NoDataWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.caption,
    required this.onTap,
    required this.showButton,
  }) : super(key: key);
  factory NoDataWidget.noFavorites() => NoDataWidget(
      title: 'No Favorites Selected',
      subTitle: '',
      caption: '',
      onTap: () {},
      showButton: false);
  factory NoDataWidget.noInternet() => NoDataWidget(
      title: 'No Internet',
      subTitle: 'Please check connection settings.',
      caption: '',
      onTap: () {},
      showButton: false);
  factory NoDataWidget.noInternetRefresh(Function onClick) => NoDataWidget(
      title: 'No Internet',
      subTitle: 'Please check connection settings.',
      caption: 'Refresh',
      onTap: () => onClick(),
      showButton: true);
  factory NoDataWidget.noData() => NoDataWidget(
      title: 'No Data',
      subTitle: 'Please check connection settings.',
      caption: '',
      onTap: () {},
      showButton: false);
  factory NoDataWidget.noService({required Function onFlip}) => NoDataWidget(
      title: 'No Service',
      subTitle: '',
      caption: 'Back',
      onTap: () => onFlip(),
      showButton: true);
  factory NoDataWidget.noLocation({required Function onClick}) => NoDataWidget(
      title: 'Location not enabled',
      subTitle: 'Please enable location service.',
      caption: 'Open App Settings',
      onTap: () => onClick(),
      showButton: true);
  factory NoDataWidget.noDataRefresh({required Function onClick}) =>
      NoDataWidget(
          title: 'No Data',
          subTitle: 'Unable to retrieve data.',
          caption: 'Refresh',
          onTap: () => onClick,
          showButton: true);
  factory NoDataWidget.noPermission({required Function onClick}) =>
      NoDataWidget(
          title: 'Location Permission not set',
          subTitle: 'Please allow to retrieve location.',
          caption: 'Open App Settings',
          onTap: () => onClick(),
          showButton: true);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.info_circle_fill, color: Colors.blueGrey, size: 50),
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                fontSize: 18)),
        subTitle.isNotEmpty
            ? Text(subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.black54))
            : SizedBox(),
        showButton
            ? SizedBox.fromSize(
                size: const Size(150, 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[700], shape: StadiumBorder()),
                  onPressed: () => onTap(),
                  child: Text(
                    caption,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
