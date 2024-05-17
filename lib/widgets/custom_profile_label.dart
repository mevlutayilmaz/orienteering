import 'package:flutter/material.dart';

import '../utils/colors/custom_colors.dart';

class CustomProfileLabel extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final IconData icon;
  final Color? textColor;
  final bool isArrow;

  const CustomProfileLabel(
      {super.key,
      required this.text,
      required this.icon,
      this.textColor,
      this.isArrow = true, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        onTap: onPress,
        leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, child: Icon(icon, color: CustomColors.buttonColor)),
        title: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor)),
        trailing: isArrow
            ? const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: CustomColors.buttonColor)
            : null,
      ),
    );
  }
}
