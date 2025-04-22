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
  final List<Vehicle> _vehicles = [];
  final List<bool> _isVinFlags = [];
  final List<GlobalKey<FormState>> _formKeys = [];
  final List<bool> _showImageErrors = [];

  void _validateAllSections() {
    bool allValid = true;

    for (int i = 0; i < _formKeys.length; i++) {
      if (!(_formKeys[i].currentState?.validate() ?? false)) {
        allValid = false;
      }

      //If there is no image show error
      if (_vehicles[i].image == null) {
        _showImageErrors[i] = true;
        allValid = false;
      }
    }

    if (allValid) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => OrderSummary(order: widget.order, vehicles: _vehicles),
        ),
      );
    } else {
      setState(() {
        
      });
    }
  }

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
            _validateAllSections();
          },
          child: Text(AppLocalizations.of(context)!.close_order),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _vehicles.length + 1,
              itemBuilder: (context, index) {
                if (index < _vehicles.length) {
                  return VehicleCard(
                    formKey: _formKeys[index],
                    vehicle: _vehicles[index],
                    isVin: _isVinFlags[index],
                    imageError: _showImageErrors[index],
                    onChanged: () => setState(() {}),
                    onToggleVinChanged: (value) {
                      setState(() {
                        _isVinFlags[index] = value;
                      });
                    },
                  );
                } else {
                  return Visibility(
                    visible: _vehicles.length < widget.order.numberOfVehicles,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                _vehicles.add(Vehicle());
                                _isVinFlags.add(false);
                                _formKeys.add(GlobalKey<FormState>());
                                _showImageErrors.add(false);
                              });
                            },
                            icon: const Icon(Icons.add, color: Colors.blueGrey),
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
