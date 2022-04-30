import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_control_app/home_controller.dart';

import 'components/door_lock.dart';
import 'components/tesla_bottom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigatonBar(
              onTap: (index) {},
              selectedTab: 0,
            ),
            body: SafeArea(child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: constrains.maxHeight * 0.1),
                    child: SvgPicture.asset(
                      'assets/icons/Car.svg',
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    right: constrains.maxWidth * 0.05,
                    child: DoorLock(
                      press: _controller.updateRightDoorLock,
                      isLock: _controller.isRightDoorLock,
                    ),
                  ),
                  Positioned(
                    left: constrains.maxWidth * 0.05,
                    child: DoorLock(
                      press: _controller.updateLeftDoorLock,
                      isLock: _controller.isLeftDoorLock,
                    ),
                  ),
                  Positioned(
                    top: constrains.maxHeight * 0.18,
                    child: DoorLock(
                      press: _controller.updateBonnetLock,
                      isLock: _controller.isBonnetLock,
                    ),
                  ),
                  Positioned(
                    bottom: constrains.maxHeight * 0.22,
                    child: DoorLock(
                      press: _controller.updateTrunkLock,
                      isLock: _controller.isTrunkLock,
                    ),
                  ),
                ],
              );
            })),
          );
        });
  }
}
