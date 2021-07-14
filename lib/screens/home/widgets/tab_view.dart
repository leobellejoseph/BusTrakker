import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  final TabController tabController;
  final ValueChanged<int> onTap;
  TabView({required this.tabController, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: TabBar(
        controller: tabController,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        indicatorWeight: 3,
        tabs: [
          const Tab(
            //icon: Icon(Icons.near_me_outlined, size: 28),
            text: 'Near Me',
          ),
          const Tab(
              //icon: Icon(Icons.bus_alert_outlined, size: 28),
              text: 'Bus Services'),
          const Tab(
            //icon: Icon(Icons.directions_bus, size: 28),
            text: 'Bus Stops',
          )
        ],
        onTap: onTap,
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return SliverToBoxAdapter(
//     child: TabBar(
//       controller: tabController,
//       labelColor: Theme.of(context).primaryColor,
//       unselectedLabelColor: Colors.grey,
//       indicatorWeight: 3,
//       tabs: [
//         const Tab(
//           //icon: Icon(Icons.near_me_outlined, size: 28),
//           text: 'Near Me',
//         ),
//         const Tab(
//           //icon: Icon(Icons.bus_alert_outlined, size: 28),
//             text: 'Bus Services'),
//         const Tab(
//           //icon: Icon(Icons.directions_bus, size: 28),
//           text: 'Bus Stops',
//         )
//       ],
//       onTap: onTap,
//     ),
//   );
// }
