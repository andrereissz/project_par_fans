import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/controllers/user_profile_controller.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/telas/reviewerProfile.dart';

class reviewDetailModal {
  int selectedAction = 0;

  static Widget getReviewDetailModal(PerfumeReview review,
      [int? selectedAction, UserProfileController? controller]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              review.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Brand: ${review.brand}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Genre: '),
                Icon(
                  review.genre == 'Feminine'
                      ? Icons.female
                      : review.genre == 'Masculine'
                          ? Icons.male
                          : Icons.gesture,
                  color: review.genre == 'Feminine'
                      ? Colors.pink
                      : review.genre == 'Masculine'
                          ? Colors.blue
                          : Colors.purple.shade400,
                ),
                SizedBox(width: 5),
                Text(
                  review.genre == 'Feminine'
                      ? 'Female'
                      : review.genre == 'Masculine'
                          ? 'Male'
                          : 'Unisex',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Occasion: '),
                Icon(
                  review.occasion == 'Night'
                      ? Icons.brightness_3
                      : review.occasion == 'Day'
                          ? Icons.wb_sunny
                          : Icons.brightness_4,
                  color: review.occasion == 'Night'
                      ? Colors.blueGrey
                      : review.occasion == 'Day'
                          ? Colors.orange.shade300
                          : Colors.red.shade300,
                ),
                SizedBox(width: 5),
                Text(
                  review.occasion == 'Night'
                      ? 'Night'
                      : review.occasion == 'Day'
                          ? 'Day'
                          : 'Versatile',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Longevity: '),
                Icon(
                  Icons.access_time,
                  color: review.longevity == 'Short'
                      ? Colors.red
                      : review.longevity == 'Moderate'
                          ? Colors.yellow.shade700
                          : Colors.green,
                ),
                SizedBox(width: 5),
                Text(
                  review.longevity,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Sillage: '),
                Icon(
                  Icons.wifi_tethering,
                  color: review.sillage == 'Intimate'
                      ? Colors.red
                      : review.sillage == 'Moderate'
                          ? Colors.yellow.shade700
                          : Colors.green,
                ),
                SizedBox(width: 5),
                Text(
                  review.sillage,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Rating: ', style: TextStyle(fontSize: 16)),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < review.overallRating
                          ? Colors.amber
                          : Colors.grey,
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (review.comment != null && review.comment.isEmpty == false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    review.comment,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            if (selectedAction == 1)
              Column(
                children: [
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red)),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text(
                              "Are you sure?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.grey),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.0),
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        controller?.deleteReview(review);
                                        Get.back();
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.0),
                                      ),
                                      child: Text(
                                        "Delete Review",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Delete Review',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            else
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => ReviewerProfile(),
                          arguments: review.reviewerId);
                    },
                    child: Text(
                      "View Profile",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
