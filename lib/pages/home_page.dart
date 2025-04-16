import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> items = [
    {'title': 'Ashkelon', 'subtitle': 'Tel Aviv', 'count': "5"},
    {'title': 'Jerusalem', 'subtitle': 'Haifa', 'count': "3"},
    {'title': 'Eilat', 'subtitle': 'Beersheba', 'count': "7"},
    {'title': 'Nazareth', 'subtitle': 'Tiberias', 'count': "4"},
    {'title': 'Netanya', 'subtitle': 'Herzliya', 'count': "6"},
    {'title': 'Rishon LeZion', 'subtitle': 'Petah Tikva', 'count': "8"},
    {'title': 'Ashdod', 'subtitle': 'Holon', 'count': "2"},
    {'title': 'Kfar Saba', 'subtitle': "Ra'anana", 'count': "9"},
    {'title': 'Bat Yam', 'subtitle': 'Ramat Gan', 'count': "5"},
    {'title': 'Modiin', 'subtitle': 'Lod', 'count': "3"},
  
    // add more items here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(item['count']!),
                          Text("cars"),
                        ],
                      ),
                      VerticalDivider(
                      ),
                      Text(item['title']!),
                      Icon(Icons.arrow_right_alt_sharp),
                      Text(item['subtitle']!),
                    ],
                  ),
                  Icon(Icons.arrow_right_rounded)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}