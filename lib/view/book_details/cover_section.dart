import 'package:flutter/material.dart';

import '../../helper/book_cover_helper.dart';
import '../../widgets/custom_image.dart';

class CoverSection extends StatefulWidget {
  const CoverSection({super.key, required this.coverKey});

  final String coverKey;

  @override
  State<CoverSection> createState() => _CoverSectionState();
}

class _CoverSectionState extends State<CoverSection> {
  double turns = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        turns = turns * 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.maxFinite,
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade200,
          ),
          Align(
            child: AnimatedRotation(
              turns: turns,
              duration: Duration(seconds: 5),
              child: CustomImage(
                height: 220,
                width: 200,
                path: BookCoverHelper.getBookCover(coverKey: widget.coverKey),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
