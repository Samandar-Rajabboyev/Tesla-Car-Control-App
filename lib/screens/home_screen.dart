import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_car_control_app/home_controller.dart';

import '../constanins.dart';
import 'components/battery_status.dart';
import 'components/door_lock.dart';
import 'components/tesla_bottom_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_controller, _batteryAnimationController]),
        builder: (context, child) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigatonBar(
              onTap: (index) {
                if (index == 1)
                  _batteryAnimationController.forward();
                else if (_controller.selectedBottomTab == 1 && index != 1) _batteryAnimationController.reverse();
                _controller.onBottomNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
            body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: constraints.maxHeight * 0.1),
                    child: SvgPicture.asset(
                      'assets/icons/Car.svg',
                      width: double.infinity,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    right: _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                      child: DoorLock(
                        press: _controller.updateRightDoorLock,
                        isLock: _controller.isRightDoorLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    left: _controller.selectedBottomTab == 0 ? constraints.maxWidth * 0.05 : constraints.maxWidth / 2,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                      child: DoorLock(
                        press: _controller.updateLeftDoorLock,
                        isLock: _controller.isLeftDoorLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    top: _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.13 : constraints.maxWidth * 0.9,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                      child: DoorLock(
                        press: _controller.updateBonnetLock,
                        isLock: _controller.isBonnetLock,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: defaultDuration,
                    bottom:
                        _controller.selectedBottomTab == 0 ? constraints.maxHeight * 0.17 : constraints.maxWidth * 0.8,
                    child: AnimatedOpacity(
                      duration: defaultDuration,
                      opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                      child: DoorLock(
                        press: _controller.updateTrunkLock,
                        isLock: _controller.isTrunkLock,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _animationBattery.value,
                    child: SvgPicture.asset(
                      'assets/icons/Battery.svg',
                      width: constraints.maxWidth * 0.45,
                    ),
                  ),
                  Positioned(
                    top: 50 * (1 - _animationBatteryStatus.value),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Opacity(
                      opacity: _animationBatteryStatus.value,
                      child: BatteryStatus(
                        constraints: constraints,
                      ),
                    ),
                  )
                ],
              );
            })),
          );
        });
  }
}
