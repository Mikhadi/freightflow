import 'package:flutter/material.dart';

class GridButtons extends StatefulWidget {
  const GridButtons({super.key});

  @override
  State<GridButtons> createState() => _GridButtonsState();
}

class _GridButtonsState extends State<GridButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          mainAxisSpacing: 25,
          crossAxisSpacing: 30,
          childAspectRatio: 1,
        ),
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
            ),
            onPressed: () {}, 
            child: Text("Open\nOrders"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
            onPressed: () {}, 
            child: Text("Closed\nOrders"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              )
            ),
            onPressed: () {}, 
            child: Text("Orders\nHistory"),
          ),
        ],
      ),
    );
  }
}
