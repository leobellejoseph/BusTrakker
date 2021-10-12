import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/repositories/repositories.dart';

class BusServiceList extends StatelessWidget {
  final String code;
  final Function onFlip;

  BusServiceList({
    Key? key,
    required this.code,
    required this.onFlip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = context.read<BusRepository>();
    final services = repo.getBusServices(code);
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          crossAxisCount: 2,
          childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        final BusService item = services[index];
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
              ),
            ],
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(2),
          ),
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.5),
            ),
            highlightColor: Colors.lightBlueAccent,
            onPressed: () => onFlip(item.serviceNo),
            child: Center(
              child: Text(
                item.serviceNo,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: item.busOperator.color),
              ),
            ),
          ),
        );
      },
    );
  }
}
