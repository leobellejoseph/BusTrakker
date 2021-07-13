import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: HomeScreen.id),
        builder: (context) => BlocProvider<BusArrivalCubit>(
          create: (context) => BusArrivalCubit(),
          child: HomeScreen(),
        ),
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
  bool _isVisible = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() => _isVisible = true);
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() => _isVisible = false);
        }
      }
    });
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
    Size size = MediaQuery.of(context).size;
    EdgeInsets insets = MediaQuery.of(context).viewInsets;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Column(
              children: [
                SizedBox(height: 155, child: FavoritesView()),
                SearchView(
                  textEditingController: _textEditingController,
                  focusNode: _focusNode,
                  onFilterData: (value) => _onFilterData(),
                  onRefreshData: _onRefreshData,
                ),
                TabView(
                  tabController: _tabController,
                  onTap: (index) => setState(() => _tabIndex = index),
                ),
                Expanded(
                  child: ContentView(tabIndex: _tabIndex),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
