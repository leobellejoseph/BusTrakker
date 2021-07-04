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
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: _onRefreshData,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('images/MyBusLogo.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (data) => _onFilterData(),
                      focusNode: _focusNode,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            onPressed: _onFilterData,
                            icon: const Icon(Icons.search,
                                color: Colors.blue, size: 30),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _onRefreshData(),
                            icon: const Icon(Icons.close,
                                color: Colors.blue, size: 30),
                          ),
                          hintText: 'Search'),
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
