import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyEventWidget extends StatelessWidget {
  const EmptyEventWidget({super.key, this.lottiePath, this.onRefresh, this.label});

  final String? lottiePath;
  final VoidCallback? onRefresh;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if ((lottiePath ?? '').isNotEmpty) LottieBuilder.asset(lottiePath!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            label ?? 'No data available!!!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey.shade700),
          ),
        ),
        if (onRefresh != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: OutlinedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ),
      ],
    );
  }
}
