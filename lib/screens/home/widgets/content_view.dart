import 'package:flutter/material.dart';

import 'widgets.dart';

enum TabIndex { near, services, stops }

class ContentView extends StatelessWidget {
  final int tabIndex;
  ContentView({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    if (tabIndex == TabIndex.near.index) {
      return NearBusStopsView();
    } else if (tabIndex == TabIndex.services.index) {
      return BusServiceView();
    } else if (tabIndex == TabIndex.stops.index) {
      return BusStopsView();
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }
}
