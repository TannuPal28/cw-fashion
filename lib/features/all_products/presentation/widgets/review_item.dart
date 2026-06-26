import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/product_detail_model.dart';
import '../../data/models/product_review_model.dart';

class ReviewItem extends StatelessWidget {
  final ProductReviewModel review;

  const ReviewItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 18,
                backgroundColor:
                Colors.grey.shade200,
                child: Text(
                  review.userName
                      .substring(0, 1)
                      .toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Row(
                  children: [

                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(width: 10),

                    if (review
                        .isVerifiedPurchase)
                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration:
                        BoxDecoration(
                          border: Border.all(
                            color:
                            Colors.green,
                          ),
                        ),
                        child: const Text(
                          "Verified Purchase",
                          style: TextStyle(
                            color:
                            Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Text(
                formatDate(
                    review.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: List.generate(
              review.rating.toInt(),
                  (index) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            review.title,
            style: const TextStyle(
              fontWeight:
              FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 5),

          Text(review.comment),

          const SizedBox(height: 12),

          Text(
            "👍 ${review.helpfulCount} Helpful",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String date) {
    final d = DateTime.parse(date);

    return "${d.day} ${_month(d.month)} ${d.year}";
  }

  String _month(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return months[month];
  }
}