import 'package:flutter/material.dart';

class SummaryAi extends StatelessWidget {
  final dynamic summary;

  const SummaryAi({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Dark background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2A2A2A), // Subtle border
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            children: [
              // Star icon
              Container(
                padding: const EdgeInsets.all(2),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF4A9EFF), // Light blue color
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Summary text
              const Text(
                'Summary',
                style: TextStyle(
                  color: Color(0xFF4A9EFF), // Light blue color
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Summary content
          Text(
            summary?.toString() ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
