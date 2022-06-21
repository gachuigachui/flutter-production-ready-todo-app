import 'package:super_do/presentation/widgets/base_screen.dart';
import 'package:super_do/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LoadingSplashScreen - FRAME
    return BaseScreen(body: buildView(context));
  }

  Widget buildView(BuildContext context) {
    String appLogo = 'assets/img/app_logo.png';
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: MediaQuery.of(context).size.height / 2 - 30,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(appLogo))),
              )),
          Positioned(
              top: 556,
              left: 0,
              right: 0,
              child: Text(
                'Accountant Pro',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.accentColor,
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.1666666666666667),
              )),
        ]));
  }
}
