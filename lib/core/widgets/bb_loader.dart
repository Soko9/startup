import 'package:flutter/material.dart';

class BBLoader extends StatelessWidget {
  const BBLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(8.0),
          backgroundColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
