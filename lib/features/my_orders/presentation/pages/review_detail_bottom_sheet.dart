import 'package:flutter/material.dart';
import '../../../cart/data/models/my_review_response.dart';


class ReviewDetailBottomSheet extends StatelessWidget {
  final MyReview review;

  const ReviewDetailBottomSheet({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Expanded(
                    child: Text(
                      review.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Times New Roman",
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 28),

              Row(
                children: List.generate(
                  5,
                      (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      index < review.rating
                          ? Icons.star
                          : Icons.star,
                      color: index < review.rating
                          ? Colors.amber
                          : Colors.grey.shade300,
                      size: 34,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                review.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                review.comment,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff555555),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    final d = DateTime.parse(date);

    return "${d.day.toString().padLeft(2, '0')}/"
        "${d.month.toString().padLeft(2, '0')}/"
        "${d.year}";
  }
}