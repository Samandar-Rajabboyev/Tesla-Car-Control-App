import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Widget> tyres(BoxConstraints constraints) {
  return [
    Positioned(
      top: constraints.maxHeight * 0.22,
      left: constraints.maxWidth * 0.2,
      child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
    ),
    Positioned(
      top: constraints.maxHeight * 0.22,
      right: constraints.maxWidth * 0.2,
      child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
    ),
    Positioned(
      top: constraints.maxHeight * 0.63,
      left: constraints.maxWidth * 0.2,
      child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
    ),
    Positioned(
      top: constraints.maxHeight * 0.63,
      right: constraints.maxWidth * 0.2,
      child: SvgPicture.asset('assets/icons/FL_Tyre.svg'),
    ),
  ];
}
