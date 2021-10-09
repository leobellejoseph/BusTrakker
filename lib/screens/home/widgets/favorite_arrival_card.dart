import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/repositories.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/widgets.dart';

class FavoriteArrivalCard extends StatefulWidget {
  final Favorite fave;
  FavoriteArrivalCard({required this.fave});
  @override
  _FavoriteArrivalCardState createState() => _FavoriteArrivalCardState();
}

class _FavoriteArrivalCardState extends State<FavoriteArrivalCard>
    with WidgetsBindingObserver {
  late FlipCardController _controller;
  late final BusRepository repo;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _controller = FlipCardController();
    repo = context.read<BusRepository>();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context
          .read<BusArrivalCubit>()
          .getBusArrival(widget.fave.busStopCode, widget.fave.serviceNo, true);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusArrivalCubit, BusArrivalState>(
      builder: (context, state) {
        if (state.status == BusArrivalStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == BusArrivalStatus.no_internet) {
          return NoDataWidget.noInternet();
        } else {
          return GestureDetector(
            onDoubleTap: () => context.read<BusArrivalCubit>().getBusArrival(
                widget.fave.busStopCode, widget.fave.serviceNo, true),
            child: FlipCard(
              controller: _controller,
              direction: FlipDirection.HORIZONTAL,
              front: FavoriteFront(
                  favorite: widget.fave,
                  arrival: state.data.firstBus,
                  repo: repo),
              back: FavoriteBack(
                  favorite: widget.fave, arrival: state.data.secondBus),
            ),
          );
        }
      },
    );
  }
}
