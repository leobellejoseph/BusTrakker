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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (_tabIndex == 0) {
        context.read<NearBusCubit>().getNearMeBusStops();
      }
    }
    super.didChangeAppLifecycleState(state);
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
      ..add(BusServiceFetch(query));
    context.read<NearBusCubit>().getNearMeBusStops(query);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SearchWidget(
                      key: ValueKey('search'),
                      onSubmit: _onFilterData,
                      controller: _textEditingController),
                  SizedBox(height: 158, child: FavoritesView()),
                  TabView(
                    key: const ValueKey('tab'),
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
}
