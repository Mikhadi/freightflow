import 'package:flutter/material.dart';
import 'package:freiightflow/classes/order_class.dart';
import 'package:freiightflow/pages/order_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Order> items = [
    Order(
      from: 'Jerusalem',
      to: 'Eilat',
      numberOfVehicles: 5,
      completed: true,
      drivers: ['Ronen Azulay', 'Sara Ben Ami', 'Oren Yitzhak'],
    ),
    Order(
      from: 'Ashdod',
      to: 'Beer Sheva',
      numberOfVehicles: 2,
      completed: false,
      drivers: ['Noa Sharon'],
    ),
    Order(
      from: 'Nazareth',
      to: 'Netanya',
      numberOfVehicles: 4,
      completed: true,
      drivers: ['Avi Malka', 'Lior Peretz'],
    ),
    Order(
      from: 'Tel Aviv',
      to: 'Haifa',
      numberOfVehicles: 3,
      completed: false,
      drivers: ['David Cohen', 'Maya Levi'],
    ),
    Order(
      from: 'ירושלים',
      to: 'אילת',
      numberOfVehicles: 5,
      completed: true,
      drivers: ['רונן אזולאי', 'שרה בן עמי', 'אורן יצחק'],
    ),
    Order(
      from: 'אשדוד',
      to: 'באר שבע',
      numberOfVehicles: 2,
      completed: false,
      drivers: ['נועה שרון'],
    ),
    Order(
      from: 'Nazareth',
      to: 'Netanya',
      numberOfVehicles: 4,
      completed: true,
      drivers: ['Avi Malka', 'Lior Peretz'],
    ),
    Order(
      from: 'ראשון לציון',
      to: 'קריית שמונה',
      numberOfVehicles: 6,
      completed: false,
      drivers: ['שי כהן', 'איתי נתן', 'גל מור'],
    ),
    Order(
      from: 'חיפה',
      to: 'תל אביב',
      numberOfVehicles: 1,
      completed: true,
      drivers: ['אלכס רוזנברג'],
    ),
    Order(
      from: 'רחובות',
      to: 'חולון',
      numberOfVehicles: 3,
      completed: false,
      drivers: ['Yael Biton', 'Daniel Shahar'],
    ),
    Order(
      from: 'פתח תקווה',
      to: 'נתיבות',
      numberOfVehicles: 2,
      completed: true,
      drivers: ['מירי כץ'],
    ),
    Order(
      from: 'מודיעין',
      to: 'עפולה',
      numberOfVehicles: 4,
      completed: false,
      drivers: ['Ron Koren', 'Shiran Ilani'],
    ),
    Order(
      from: 'צפת',
      to: 'חדרה',
      numberOfVehicles: 5,
      completed: true,
      drivers: ['Tamar Nissim', 'Erez Avrahami'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderPage(order: item,) )),
            child: Card(
              elevation: 2,
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [Text(item.numberOfVehicles.toString()), Text(AppLocalizations.of(context)!.cars)]),
                        VerticalDivider(),
                        Text(item.from),
                        Icon(Icons.arrow_right_alt_sharp),
                        Text(item.to),
                      ],
                    ),
                    Icon(Icons.arrow_right_rounded),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
