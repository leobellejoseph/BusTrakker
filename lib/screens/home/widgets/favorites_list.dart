import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/favorite_arrival_card.dart';
import 'package:my_bus/widgets/centered_spinner.dart';
import 'package:my_bus/widgets/widgets.dart';

class FavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == FavoriteStatus.no_data) {
          return SizedBox(
            height: 125,
            child: NoDataWidget(
                title: 'No Favorites Selected',
                subTitle: '',
                caption: '',
                onTap: () {},
                showButton: false),
          );
          // return CenteredText(text: 'No Favorites Selected');
        } else {
          return SizedBox(
            height: 126,
            child: ListView.builder(
              itemCount: state.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final favorite = state.data[index];
                final cubit = context.read<FavoritesCubit>();
                final arrival = BusArrivalCubit();
                return BlocProvider<BusArrivalCubit>(
                  create: (context) => arrival
                    ..getBusArrival(
                        favorite.busStopCode, favorite.serviceNo, true),
                  child: Slidable(
                    direction: Axis.vertical,
                    actions: [
                      IconSlideAction(
                        //caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => cubit.removeFavorite(
                            code: favorite.busStopCode,
                            service: favorite.serviceNo),
                      ),
                    ],
                    actionPane: SlidableDrawerActionPane(),
                    child: _showCardContent(context, favorite),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _showCardContent(BuildContext context, Favorite favorite) {
    return Container(
      height: double.infinity,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _showCardHeader(context, favorite),
            Expanded(
              child: FavoriteArrivalCard(fave: favorite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showCardHeader(BuildContext context, Favorite favorite) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 25,
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: favorite.serviceNo,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const TextSpan(
                text: ' @ ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextSpan(
                text: favorite.busStopCode,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
