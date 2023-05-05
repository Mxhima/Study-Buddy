import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LecturerDetailsModalWidget extends StatefulWidget {
  const LecturerDetailsModalWidget({super.key});

  @override
  State<LecturerDetailsModalWidget> createState() =>
      _LecturerDetailsModalWidgetState();
}

class _LecturerDetailsModalWidgetState
    extends State<LecturerDetailsModalWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isModalShown = false;

    void _toggleModal() {
      setState(() {
        _isModalShown = !_isModalShown;
      });
    }

    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: _isModalShown ? 0 : -200,
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text('Modal content'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
