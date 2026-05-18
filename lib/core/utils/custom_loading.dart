import 'package:flutter/cupertino.dart';
import 'package:nutrilens/core/constants/color_manager.dart';

Widget customLoading({Color? color = ColorsManager.primary}) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Center(child: CupertinoActivityIndicator(color: color)),
  );
}
