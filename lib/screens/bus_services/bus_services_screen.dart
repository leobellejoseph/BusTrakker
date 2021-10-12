import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusServiceScreen extends StatelessWidget {
  static const id = 'service';
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: BusServiceScreen.id),
        builder: (context) => BusServiceScreen(),
      );
  final controller = TextEditingController();
  BusServiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.blue.shade900,
              size: 30,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context
                    .read<BusDataBloc>()
                    .add(BusServiceFetch(controller.text));
              }
            }),
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
              hintText: 'Bus Services',
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
                if (controller.text.isNotEmpty) {
                  controller.clear();
                  context
                      .read<BusDataBloc>()
                      .add(BusServiceFetch(controller.text));
                }
              }),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<BusDataBloc, BusDataState>(
        builder: (context, state) {
          if (state.status == BusDataStatus.busServiceLoading) {
            return const CenteredSpinner();
          } else if (state.status == BusDataStatus.no_internet) {
            return NoDataWidget(
                key: ValueKey('serviceNoData'),
                title: 'No Internet',
                subTitle: 'Please check connection settings.',
                caption: 'Refresh',
                onTap: () =>
                    context.read<BusDataBloc>()..add(BusDataDownload()),
                showButton: false);
          } else {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
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
                            Colors.blue.withOpacity(0.6),
                            Colors.blue.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: FlexibleSpaceBar(
                        background: Hero(
                          tag: 'busservices',
                          child: Image.asset('images/buslogo.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverStaggeredGrid.countBuilder(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 4,
                  itemBuilder: (context, index) {
                    final item = state.serviceData[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ServiceWidget(
                        key: ValueKey(item.serviceNo),
                        service: item,
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    final item = state.serviceData[index];
                    final number = num.tryParse(item.serviceNo);
                    return StaggeredTile.count(2, number == null ? 2 : 1);
                  },
                  itemCount: state.serviceData.length,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
