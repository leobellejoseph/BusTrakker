import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/home/cubit/near_stops_cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: HomeScreen.id),
        builder: (context) => BlocProvider(
          create: (context) =>
              NearStopsCubit(busStopBloc: context.read<BusStopBloc>()),
          child: HomeScreen(),
        ),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final inset = MediaQuery.of(context).viewInsets;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => print(_textEditingController.text),
            icon: Icon(
              Icons.search,
              color: Colors.blue,
              size: 30,
            ),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () => _textEditingController.clear(),
              icon: Icon(
                Icons.cancel,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ],
          title: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: 'Search'),
          ),
        ),
        body: GestureDetector(
          onTap: () async => FocusScope.of(context).unfocus(),
          child: RefreshIndicator(
            onRefresh: () async {},
            child: CustomScrollView(
              slivers: [
                _favoritesView(),
                _tabView(),
                _nearListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _favoritesView() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.lightBlue.withOpacity(0.2),
            //     Colors.lightBlue.withOpacity(0.5),
            //   ],
            // ),
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
              const Divider(color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabView() {
    return SliverToBoxAdapter(
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        indicatorWeight: 3,
        tabs: [
          Tab(
            //icon: Icon(Icons.near_me_outlined, size: 28),
            text: 'Near Me',
          ),
          Tab(
              //icon: Icon(Icons.bus_alert_outlined, size: 28),
              text: 'Bus Services'),
          Tab(
            //icon: Icon(Icons.directions_bus, size: 28),
            text: 'Bus Stops',
          )
        ],
        onTap: (index) => print(index),
      ),
    );
  }

  Widget _nearGridView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            color: Colors.red,
          );
        },
        childCount: 4,
      ),
    );
  }

  Widget _nearListView() {
    return NearBusStops();
  }
}
