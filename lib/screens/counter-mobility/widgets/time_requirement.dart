import 'package:flutter/material.dart';

import '../../../shared/widgets/section_heading.dart';

class TimeRequirement extends StatelessWidget {
  const TimeRequirement({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionHeading("2. ", "Time Requirement");
  }
}
