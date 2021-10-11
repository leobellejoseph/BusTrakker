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
    final size = MediaQuery.of(context).size;
    final insets = MediaQuery.of(context).viewInsets;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: AlignmentDirectional.bottomEnd,
                    fit: BoxFit.contain,
                    image: AssetImage('images/background1.jpg'),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blueAccent.withOpacity(0.5),
                      Colors.blueAccent.withOpacity(0.3),
                      Colors.blueAccent.withOpacity(0.2),
                      Colors.blueAccent.withOpacity(0),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.deepPurple.withOpacity(0.2),
                        Colors.deepPurple.withOpacity(0.6),
                      ],
                    ),
                  ),
                  height: 250,
                ),
              ),
              Positioned(
                top: 5,
                left: 120,
                child: SizedBox(
                    width: 150,
                    height: 110,
                    child: Image.asset('images/sglovebus.png')),
              ),
              Positioned(
                top: 70,
                child: SizedBox.fromSize(
                  size: Size(size.width, 300),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.5),
                      child: FavoritesList(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 350,
                child: SizedBox.fromSize(
                  size: Size(size.width, 245),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.5),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 580,
                child: SizedBox.fromSize(
                  size: Size(size.width, 180),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                shadowColor: Colors.grey,
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  highlightColor: Colors.blue,
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child:
                                              Image.asset('images/buslogo.png'),
                                        ),
                                      ),
                                      Positioned(
                                        left: 30,
                                        top: 10,
                                        child: Text('Bus Services',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.blueAccent)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                shadowColor: Colors.grey,
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  highlightColor: Colors.blue,
                                  onTap: () {},
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child:
                                              Image.asset('images/busstop.png'),
                                        ),
                                      ),
                                      Positioned(
                                        left: 45,
                                        top: 10,
                                        child: Text('Bus Stops',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.deepPurple)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
