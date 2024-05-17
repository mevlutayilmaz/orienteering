import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orienteering/utils/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController  controller;
  final String hint;
  final IconData iconData;
  final bool visibleSuffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({super.key, required this.controller, required this.hint, required this.iconData, this.visibleSuffixIcon = false, this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.hint == LocaleConstants.email.tr() ? TextInputType.emailAddress : TextInputType.text,
        obscureText: widget.visibleSuffixIcon ? !_passwordVisible : false,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.iconData),
          hintText: widget.hint,
          suffixIcon: widget.visibleSuffixIcon
              ? IconButton(
                  icon: _passwordVisible
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : const SizedBox(),
        ),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}