import 'package:flutter/material.dart';
import 'package:freiightflow/core/constants.dart';
import 'package:freiightflow/pages/nav_page.dart';
import 'package:freiightflow/pages/widgets/drive_in_truck.dart';
import 'package:freiightflow/pages/widgets/text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isTextField = false;
  bool isSignIn = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: greenColor,
      appBar: AppBar(
        title: Text('', style: textStyle),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(  
            padding: const EdgeInsets.all(0),
            child: DriveInTruck(), //Image.asset('assets/truck.png'),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: keyboardOpen ? Colors.white : Colors.transparent,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Text("${AppLocalizations.of(context)!.welcome_to}${AppLocalizations.of(context)!.app_name}!", style: textStyle),
                const SizedBox(height: 30),
                AnimatedCrossFade(
                  firstChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isTextField = true;
                            isSignIn = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.sign_in, style: textStyle),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isTextField = true;
                            isSignIn = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(300, 40),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.create_account),
                      ),
                    ],
                  ),
                  secondChild: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: kPadding10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldWidget(
                          controller: emailController,
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIconData: Icons.email,
                        ),
                        const SizedBox(height: 10),
                        TextFieldWidget(
                          controller: passwordController,
                          hintText: AppLocalizations.of(context)!.password,
                          prefixIconData: Icons.password,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CloseButton(
                              onPressed: () {
                                setState(() {
                                  isTextField = false;
                                });
                              },
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const NavPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child:
                                    isSignIn
                                        ? Text(AppLocalizations.of(context)!.sign_in, style: textStyle)
                                        : Text(
                                          AppLocalizations.of(context)!.create_account,
                                          style: textStyle,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  crossFadeState:
                      isTextField
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
