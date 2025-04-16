import 'package:flutter/material.dart';
import 'package:freiightflow/classes/order_class.dart';
import 'package:freiightflow/classes/vehicle_class.dart';
import 'package:freiightflow/pages/order_summary.dart';
import 'package:freiightflow/pages/widgets/vehicle_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OrderPage extends StatefulWidget {
  final Order order;

  const OrderPage({super.key, required this.order});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<Vehicle> vehicles = [];
  final List<bool> isVinFlags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.order.from),
            Icon(Icons.arrow_right_alt_sharp),
            Text(widget.order.to),
          ],
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) =>
                        OrderSummary(order: widget.order, vehicles: vehicles),
              ),
            );
          },
          child: Text(AppLocalizations.of(context)!.close_order),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length + 1,
              itemBuilder: (context, index) {
                if (index < vehicles.length) {
                  return VehicleCard(
                    vehicle: vehicles[index],
                    isVin: isVinFlags[index],
                    onChanged: () => setState(() {}),
                    onToggleVinChanged: (value) {
                      setState(() {
                        isVinFlags[index] = value;
                      });
                    },
                  );
                } else {
                  return Visibility(
                    visible: vehicles.length < widget.order.numberOfVehicles,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue
                        ),
                        child: Center(
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                vehicles.add(Vehicle());
                                isVinFlags.add(false);
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
