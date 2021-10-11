import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/centered_spinner.dart';
import 'package:my_bus/widgets/widgets.dart';

// class FavoritesList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return BlocBuilder<FavoritesCubit, FavoritesState>(
//       builder: (context, state) {
//         if (state.status == FavoriteStatus.loading) {
//           return CenteredSpinner();
//         } else if (state.status == FavoriteStatus.no_data) {
//           return NoDataWidget.noFavorites();
//         } else {
//           return Padding(
//             padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   height: 126,
//                   child: ListView.builder(
//                     itemCount: state.data.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       final fav = state.data[index];
//                       final cubit = context.read<FavoritesCubit>();
//                       final arrival = BusArrivalCubit();
//                       return BlocProvider<BusArrivalCubit>(
//                         create: (context) => arrival
//                           ..getBusArrival(fav.busStopCode, fav.serviceNo, true),
//                         child: Slidable(
//                           direction: Axis.vertical,
//                           actions: [
//                             IconSlideAction(
//                               //caption: 'Delete',
//                               color: Colors.red,
//                               icon: Icons.delete,
//                               onTap: () => cubit.removeFavorite(
//                                   fav.busStopCode, fav.serviceNo),
//                             ),
//                           ],
//                           actionPane: SlidableDrawerActionPane(),
//                           child: FavoriteCardContent(favorite: fav),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const Divider(color: Colors.black54),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }
class FavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == FavoriteStatus.no_data) {
          return NoDataWidget.noFavorites();
        } else {
          return Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final fav = state.data[index];
                      final cubit = context.read<FavoritesCubit>();
                      final arrival = BusArrivalCubit();
                      return BlocProvider<BusArrivalCubit>(
                        create: (context) => arrival
                          ..getBusArrival(fav.busStopCode, fav.serviceNo, true),
                        child: Slidable(
                          direction: Axis.vertical,
                          actions: [
                            IconSlideAction(
                              //caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => cubit.removeFavorite(
                                  fav.busStopCode, fav.serviceNo),
                            ),
                          ],
                          actionPane: SlidableDrawerActionPane(),
                          child: FavoriteCardContent(favorite: fav),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
