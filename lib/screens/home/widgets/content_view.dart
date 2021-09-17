import 'package:flutter/material.dart';

import 'widgets.dart';

enum TabIndex { near, services, stops }

class ContentView extends StatelessWidget {
  final int tabIndex;
  ContentView({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    if (tabIndex == TabIndex.near.index) {
      return NearBusStopsView(key: ValueKey('nearBusStopsView'));
    } else if (tabIndex == TabIndex.services.index) {
      return BusServiceView(key: ValueKey('serviceView'));
    } else if (tabIndex == TabIndex.stops.index) {
      return BusStopsView(key: ValueKey('stopsView'));
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }
}
