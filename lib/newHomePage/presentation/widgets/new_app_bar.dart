import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freiightflow/newHomePage/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAppbar extends ConsumerStatefulWidget {
  const NewAppbar({super.key});

  @override
  ConsumerState<NewAppbar> createState() => _NewAppbarState();
}

class _NewAppbarState extends ConsumerState<NewAppbar> {
  
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome back!", style: GoogleFonts.rubik(fontSize: 24, color: Colors.white)),
                Text(user!.name, style: GoogleFonts.rubik(fontSize: 18, color: Colors.white),),
              ],
            ),
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 30,),
            )
          ],
        ),
      ),
    );
  }
}