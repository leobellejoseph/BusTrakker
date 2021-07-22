import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  int _tabIndex = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print('Fore Ground');
      context.read<FavoritesCubit>().fetch();
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _tabController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _onFilterData(String query) {
    context.read<BusDataBloc>()
      ..add(BusStopFetch(query))
      ..add(BusServiceFetch(query))
      ..add(NearBusStopsFetch(query));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SizedBox(height: 158, child: FavoritesView()),
                  _searchView(),
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
      ),
    );
  }

  Widget _searchView() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: (value) {
          _onFilterData(value);
        },
        controller: _textEditingController,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: IconButton(
              onPressed: () => _onFilterData(_textEditingController.text),
              icon: const Icon(Icons.search, color: Colors.blue, size: 30),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                _textEditingController.clear();
                FocusScope.of(context).unfocus();
                _onFilterData('');
              },
              icon: const Icon(Icons.close, color: Colors.blue, size: 30),
            ),
            hintText: 'Search'),
      ),
    );
  }
}
