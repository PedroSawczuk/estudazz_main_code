import 'package:flutter/material.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';

class UserInfoCard extends StatelessWidget {
  final String infoName;
  final IconData iconData;
  final String infoValue;

  const UserInfoCard({
    super.key,
    required this.infoName,
    required this.iconData,
    required this.infoValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 150,
        height: 130,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 28, color: ConstColors.orangeColor),
            ConstSizedBox.h10,
            Text(
              infoName,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            ConstSizedBox.h5,
            Text(
              infoValue,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ConstColors.orangeColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
