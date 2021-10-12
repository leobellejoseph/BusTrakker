import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  bool _loading = false;
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final insets = MediaQuery.of(context).viewInsets;

    final resetData = () {
      HydratedBloc.storage.clear();
      context.read<BusDataBloc>().add(BusDataDownload());
      setState(() => _loading = true);
    };

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: () async => false,
        child: ModalProgressHUD(
          progressIndicator: SpinKitPouringHourGlassRefined(
              color: Colors.deepPurple, size: 60),
          inAsyncCall: _loading,
          child: BlocListener<BusDataBloc, BusDataState>(
            listener: (context, state) {
              if (state.status == BusDataStatus.allLoaded) {
                setState(() => _loading = false);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  const HomeScreenBackground(),
                  const HomeScreenTopOverlay(), //purple overlay
                  HomeScreenLogo(insets: insets), //sg love bus logo
                  Positioned(
                    top: 35,
                    left: insets.right + 300,
                    child: IconButton(
                      tooltip: 'Reset Data',
                      onPressed: () => _loading ? null : resetData(),
                      icon: Icon(
                        FontAwesomeIcons.fileDownload,
                        color: Colors.green.shade700,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    child: SizedBox.fromSize(
                      size: Size(size.width, 280),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 10),
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

class HomeScreenTopOverlay extends StatelessWidget {
  const HomeScreenTopOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
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
        height: 345,
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
      top: 3,
      left: insets.left + 10,
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
      top: 345,
      child: SizedBox.fromSize(
        size: Size(size.width, 170),
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
                          context.read<BusDataBloc>().add(BusServiceFetch(''));
                          Navigator.pushNamed(context, BusServiceScreen.id);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Hero(
                                  tag: 'busservices',
                                  child: Image.asset('images/buslogo.png')),
                            ),
                            Positioned(
                              left: 30,
                              top: 10,
                              child: Text('Bus Services',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueGrey.shade700)),
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
                          context.read<BusDataBloc>().add(BusStopFetch(''));
                          Navigator.pushNamed(context, BusStopsScreen.id);
                        },
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Hero(
                                    tag: 'busstops',
                                    child: Image.asset('images/busstop.png')),
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
    if (size.height <= 600) {
      return Positioned(
        top: 510,
        child: SizedBox.fromSize(
          size: Size(size.width, 55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                highlightColor: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
                onTap: () =>
                    Navigator.pushNamed(context, NearBusStopsScreen.id),
                child: Card(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  color: Colors.white.withOpacity(0.4),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.list,
                            color: Colors.green.shade700, size: 30),
                        const SizedBox(width: 10),
                        Text('Show Bus Stops Near You',
                            style: GoogleFonts.oxygen(
                                fontWeight: FontWeight.w500, fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Positioned(
        top: 510,
        child: SizedBox.fromSize(
          size: Size(size.width, 250),
          child: Card(
            color: Colors.white.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                      Material(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
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
