import 'package:flutter/material.dart';
import 'constants/colors.dart';

class LayoutPsychSection extends StatefulWidget {
  final String question;
  final answer;
  const LayoutPsychSection({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<LayoutPsychSection> createState() => _LayoutPsychSectionState();
}

class _LayoutPsychSectionState extends State<LayoutPsychSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.02,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                '${widget.question}',
                style: questionStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: widget.answer == 'Yes'
                      ? Color(0xff14A44D)
                      : Color(0xffFF031B),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
