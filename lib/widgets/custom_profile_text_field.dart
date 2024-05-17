import 'package:flutter/material.dart';

class CustomProfileTextField extends StatefulWidget {
  final TextEditingController  controller;
  final String text;
  final IconData iconData;
  final bool visibleSuffixIcon;
  final bool isEnabled;
  final bool maxLines;
  final TextInputType? inputType;
  final String? Function(String?)? validator;

  const CustomProfileTextField({super.key, required this.controller, required this.text, required this.iconData, this.visibleSuffixIcon = false, this.isEnabled = true, this.inputType, this.validator, this.maxLines = false});

  @override
  State<CustomProfileTextField> createState() => _CustomProfileTextFieldState();
}

class _CustomProfileTextFieldState extends State<CustomProfileTextField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: widget.maxLines ? null : 1,
        onChanged: (_) => setState(() {}),
        controller: widget.controller,
        obscureText: widget.visibleSuffixIcon ? !_passwordVisible : false,
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          suffixIcon: widget.visibleSuffixIcon
              ? IconButton(
                  icon: _passwordVisible
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                  onPressed: () => setState(() {_passwordVisible = !_passwordVisible;}),
                )
              : null,
          prefixIcon: Icon(widget.iconData),
          labelText: widget.text,
          alignLabelWithHint: true,
        ),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}