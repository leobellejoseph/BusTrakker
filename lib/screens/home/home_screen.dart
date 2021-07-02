import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: HomeScreen.id),
        builder: (context) => HomeScreen(),
      );

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _tabIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onFilterData() {
    final query = _textEditingController.text;
    context.read<BusDataBloc>()
      ..add(BusStopFetch(query))
      ..add(BusServiceFetch(query))
      ..add(NearBusStopsFetch(query));
  }

  Future<void> _onRefreshData() async {
    // clear filters
    _textEditingController.clear();
    // fetch fresh data
    _onFilterData();
    // close keyboard
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onLongPress: () {
          _focusNode.requestFocus();
          _scrollController.jumpTo(0);
        },
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //     onPressed: _onFilterData,
          //     icon: Icon(Icons.search, color: Colors.blue, size: 30),
          //   ),
          //   backgroundColor: Colors.white,
          //   actions: [
          //     IconButton(
          //       onPressed: _onRefreshData,
          //       icon: Icon(Icons.cancel, color: Colors.green[500], size: 30),
          //     ),
          //     const SizedBox(width: 5),
          //   ],
          //   title: TextField(
          //     onSubmitted: (data) => _onFilterData(),
          //     focusNode: _focusNode,
          //     controller: _textEditingController,
          //     decoration: InputDecoration(hintText: 'Search'),
          //   ),
          // ),
          body: RefreshIndicator(
            onRefresh: _onRefreshData,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        Image.asset('images/MyBusLogo.jpg', fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onSubmitted: (data) => _onFilterData(),
                        focusNode: _focusNode,
                        controller: _textEditingController,
                        decoration: InputDecoration(hintText: 'Search'),
                      ),
                    ),
                  ),
                ),
                FavoritesView(),
                TabView(
                  tabController: _tabController,
                  onTap: (index) => setState(() => _tabIndex = index),
                ),
                ContentView(tabIndex: _tabIndex),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
