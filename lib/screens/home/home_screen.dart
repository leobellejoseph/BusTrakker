import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/screens/screens.dart';

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
              const HomeScreenBackground(),
              const HomeScreenFavorites(), //purple overlay
              HomeScreenLogo(insets: insets), //sg love bus logo
              Positioned(
                top: 70,
                child: SizedBox.fromSize(
                  size: Size(size.width, 300),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FavoritesList(),
                  ),
                ),
              ), //favorites
              HomeScreenButtons(size: size),
              HomeScreenNearBusStops(size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenBackground extends StatelessWidget {
  const HomeScreenBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class HomeScreenFavorites extends StatelessWidget {
  const HomeScreenFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
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
        height: 360,
      ),
    );
  }
}

class HomeScreenLogo extends StatelessWidget {
  final EdgeInsets insets;
  const HomeScreenLogo({Key? key, required this.insets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: insets.left + 120,
      child: SizedBox(
          width: 150, height: 110, child: Image.asset('images/sglovebus.png')),
    );
  }
}

class HomeScreenButtons extends StatelessWidget {
  final Size size;
  const HomeScreenButtons({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 360,
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
                        onTap: () {
                          Navigator.pushNamed(context, BusServiceScreen.id);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset('images/buslogo.png'),
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
                        onTap: () {
                          Navigator.pushNamed(context, BusStopsScreen.id);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset('images/busstop.png'),
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
    );
  }
}

class HomeScreenNearBusStops extends StatelessWidget {
  final Size size;
  const HomeScreenNearBusStops({Key? key, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size.height < 800) {
      return Positioned(
        top: 530,
        child: SizedBox.fromSize(
          size: Size(size.width, 50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white.withOpacity(0.4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin, color: Colors.green.shade700),
                    Text('Near Me'),
                    Icon(Icons.expand, color: Colors.deepPurple),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        top: 535,
        child: SizedBox.fromSize(
          size: Size(size.width, 250),
          child: Card(
            color: Colors.white.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          highlightColor: Colors.white,
                          onTap: () async =>
                              context.read<NearBusCubit>().getNearMeBusStops(),
                          child: Icon(
                            CupertinoIcons.refresh_circled_solid,
                            color: Colors.green,
                            size: 35,
                          ),
                        ),
                      ),
                      Text('Bus Stop Closest To You',
                          style: GoogleFonts.oxygen(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                      Material(
                        color: Colors.blueAccent,
                        shape: CircleBorder(),
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, NearBusStopsScreen.id),
                          child:
                              Icon(Icons.list, color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                  NearBusStopsView(showAll: false),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
