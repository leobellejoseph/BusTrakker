import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusStopsScreen extends StatelessWidget {
  static const id = 'busstops';
  static Route route() => MaterialPageRoute(
        builder: (context) => BusStopsScreen(),
        settings: const RouteSettings(name: BusStopsScreen.id),
      );
  final controller = TextEditingController();
  final scrollController = ScrollController();
  BusStopsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.blue.shade900,
              size: 30,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<BusDataBloc>().add(BusStopFetch(controller.text));
              }
            }),
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.6),
                Colors.blue.withOpacity(0.2),
              ],
            ),
          ),
        ),
        title: TextFormField(
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.blueGrey.shade700,
              fontSize: 20),
          controller: controller,
          showCursor: true,
          cursorColor: Colors.blueAccent.shade700,
          decoration: InputDecoration(
              hintText: 'Bus Stops',
              hintStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        actions: [
          IconButton(
              icon: Icon(
                CupertinoIcons.clear,
                color: Colors.blue.shade900,
                size: 30,
              ),
              onPressed: () {
                scrollController.jumpTo(0);
                if (controller.text.isNotEmpty) {
                  controller.clear();
                  context
                      .read<BusDataBloc>()
                      .add(BusStopFetch(controller.text));
                }
              }),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<BusDataBloc, BusDataState>(
        builder: (context, state) {
          if (state.status == BusDataStatus.busStopsLoading) {
            return SliverToBoxAdapter(child: CenteredSpinner());
          } else if (state.status == BusDataStatus.no_internet) {
            return NoDataWidget(
                title: 'No Internet',
                subTitle: 'Please check connection settings.',
                caption: 'Refresh',
                onTap: () {
                  context.read<BusDataBloc>()..add(BusDataDownload());
                },
                showButton: false);
          } else {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,
                        color: Colors.blueAccent, size: 30),
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: 200.0,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.8),
                            Colors.blue.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: FlexibleSpaceBar(
                          background: Hero(
                            tag: 'busstops',
                            child: Image.asset('images/busstop.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = state.stopsData[index];
                      return BusStopTile(item: item, showDistance: false);
                    },
                    childCount: state.stopsData.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
