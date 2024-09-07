import 'package:flutter/material.dart';

class CheckboxTexed extends StatefulWidget {
  const CheckboxTexed({
    required this.onChanged,
    super.key,
  });

  // ignore: avoid_positional_boolean_parameters
  final void Function(bool value) onChanged;
  @override
  State<CheckboxTexed> createState() => _CheckboxTexedState();
}

class _CheckboxTexedState extends State<CheckboxTexed> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        value: _isChecked,
        onChanged: (newValue) {
          setState(() {
            _isChecked = newValue ?? false;
          });
          widget.onChanged.call(_isChecked);
        },
      ),
    );
  }
}
