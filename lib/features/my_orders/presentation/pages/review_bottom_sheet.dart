import 'dart:io';

import 'package:cw_fashion/features/my_orders/presentation/bloc/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewBottomSheet extends StatelessWidget {

  final String productName;

  final String productId;

  final String vendorId;

  final String orderId;

  final String orderItemId;

  const ReviewBottomSheet({
    super.key,
    required this.productName,
    required this.productId,
    required this.vendorId,
    required this.orderId,
    required this.orderItemId,
  });


  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewProvider>(
      builder: (_, provider, __) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Write Review",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Overall Rating",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          provider.setRating(index + 1.0);
                        },
                        icon: Icon(
                          Icons.star,
                          color: provider.rating >= index + 1
                              ? Colors.amber
                              : Colors.grey.shade300,
                          size: 34,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 25),
                  const Text(
                    "Review Title",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: provider.titleController,
                    decoration: InputDecoration(
                      hintText: "Enter Review Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Review",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: provider.commentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write your review...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Add Photos",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      InkWell(
                        onTap: provider.uploadingImage
                            ? null
                            : provider.pickImages,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: provider.uploadingImage
                              ? const Center(child: CircularProgressIndicator())
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt),
                                    SizedBox(height: 6),
                                    Text("Add"),
                                  ],
                                ),
                        ),
                      ),

                      ...List.generate(
                        provider.imageFiles.length,
                        (index) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                provider.imageFiles[index],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 2,
                              right: 2,
                              child: InkWell(
                                onTap: () {
                                  provider.removeImage(index);
                                },
                                child: const CircleAvatar(
                                  radius: 11,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Add Video",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),
                  Column(
                    children: [
                      InkWell(
                        onTap: provider.uploadingVideo
                            ? null
                            : provider.pickVideos,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: provider.uploadingVideo
                              ? const Center(child: CircularProgressIndicator())
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.video_call),

                                    SizedBox(width: 10),

                                    Text("Select Video"),
                                  ],
                                ),
                        ),
                      ),

                      if (provider.videoFile != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.video_file),

                              const SizedBox(width: 10),

                              const Expanded(child: Text("Video Uploaded")),

                              IconButton(
                                onPressed: provider.removeVideo,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 25),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: provider.anonymous,
                    onChanged: (value) {
                      provider.toggleAnonymous(value!);
                    },
                    title: const Text(
                      "Post review anonymously",
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: provider.isLoading
                          ? null
                          : () async {

                        final success =
                        await provider.submitReview(

                          productId: productId,

                          vendorId: vendorId,

                          orderId: orderId,

                          orderItemId: orderItemId,

                        );

                        if (!context.mounted) return;

                        if (success) {

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                "Review submitted successfully",
                              ),
                            ),
                          );

                        } else {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                "Failed to submit review",
                              ),
                            ),
                          );

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: provider.isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        "SUBMIT REVIEW",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
