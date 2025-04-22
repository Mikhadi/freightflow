import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freiightflow/classes/order_class.dart';
import 'package:freiightflow/classes/vehicle_class.dart';
import 'package:freiightflow/notifiers/locale_notifier.dart';
import 'package:freiightflow/pages/nav_page.dart';
import 'package:slide_action/slide_action.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderSummary extends StatefulWidget {
  final Order order;
  final List<Vehicle> vehicles;
  const OrderSummary({super.key, required this.order, required this.vehicles});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  String formatPlate(String? plateNum) {
    if (plateNum == null) return '';

    if (plateNum.length == 7) {
      return '${plateNum.substring(0, 2)}-${plateNum.substring(2, 5)}-${plateNum.substring(5, 7)}';
    } else if (plateNum.length == 8) {
      return '${plateNum.substring(0, 3)}-${plateNum.substring(3, 5)}-${plateNum.substring(5, 8)}';
    }

    return plateNum; // fallback: return raw if length doesn't match
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                bool isVin = widget.vehicles[index].vin != null;
                return ListTile(
                  title: Text(
                    "${widget.vehicles[index].make} ${widget.vehicles[index].model}",
                  ),
                  subtitle: Text(
                    "${isVin == true ? AppLocalizations.of(context)!.vin : AppLocalizations.of(context)!.plate_num} ${isVin == true ? widget.vehicles[index].vin : formatPlate(widget.vehicles[index].plateNumber)}",
                  ),
                  leading: Text((index + 1).toString()),
                  trailing:
                      widget.vehicles[index].image is File
                          ? Image.file(
                            widget.vehicles[index].image as File,
                            height: 100,
                          )
                          : null,
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: widget.vehicles.length,
            ),
          ),
          SlideAction(
            stretchThumb: true,
            rightToLeft: localeNotifier.value.languageCode == "he",
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8),
                  ],
                ),
                child: Center(child: Text(AppLocalizations.of(context)!.send)),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  // Show loading indicator if async operation is being performed
                  child:
                      state.isPerformingAction
                          ? Text(
                            AppLocalizations.of(context)!.sending,
                            style: TextStyle(color: Colors.white),
                          )
                          : const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                ),
              );
            },
            action: () async {
              // Async operation
              await Future.delayed(const Duration(seconds: 2));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        AppLocalizations.of(context)!.sended_succesfully,
                      ),
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blueGrey,
                  ),
                );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavPage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
