import 'package:flutter/material.dart';
import 'package:my_database/themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key,  required this.onTap, required this.radius, required this.label, required this.isCheck}) : super(key: key);

  final VoidCallback onTap;
  final double radius;
  final String label;
  final bool isCheck;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: isCheck ? Themes().theme.primaryColor : Colors.transparent,
        child: InkWell(
            splashColor: Themes().theme.primaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(radius)),
                border: Border.all(color: Themes().theme.primaryColor, width: 1.5),
              ),
              height: 40.0,
              width: 100.0,
              child: Center(
                  child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isCheck ? Colors.white : Themes().theme.primaryColor,
                      )
                  )
              ),
            ),
            onTap: () {
              onTap();
            }
        ),
      ),
    );
  }
}
