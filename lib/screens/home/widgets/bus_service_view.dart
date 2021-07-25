import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/bus_route/bus_route_screen.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';
import 'package:my_bus/widgets/centered_spinner.dart';
import 'package:my_bus/widgets/no_data_widget.dart';

class BusServiceView extends StatelessWidget {
  Widget _serviceButton(BuildContext context, BusService item) {
    final BusOperator operator = item.busOperator;
    return RawMaterialButton(
      onPressed: () {
        context.read<BusRouteCubit>().fetchRoute(service: item.serviceNo);
        showModalBottomSheet(
          backgroundColor: Colors.white,
          elevation: 2,
          context: context,
          builder: (context) {
            return BusRouteScreen(service: item.serviceNo, code: '');
          },
        );
      },
      highlightColor: operator.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                operator.color.withOpacity(0.9),
                operator.color.withOpacity(0.3),
                operator.color.withOpacity(0.2),
              ]),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              operator.name,
              style: TextStyle(
                  color: operator.textColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            const Divider(color: Colors.black54, height: 0),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  item.serviceNo,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busServiceLoading) {
          return CenteredSpinner();
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
          return StaggeredGridView.countBuilder(
            itemCount: state.serviceData.length,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              final item = state.serviceData[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: _serviceButton(context, item),
              );
            },
            staggeredTileBuilder: (index) {
              final item = state.serviceData[index];
              final number = num.tryParse(item.serviceNo);
              return StaggeredTile.count(2, number == null ? 2 : 1);
            },
          );
        }
      },
    );
  }
}
