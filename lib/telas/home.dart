import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/controllers/home_controller.dart';
import 'package:project_par_fans/reviewDetailModal.dart';

class Home extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomnav.getBarraNav(0),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.displayedReviews.isEmpty) {
          return Center(child: Text('No reviews available.'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshReviews,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.displayedReviews.length,
                  itemBuilder: (context, index) {
                    final review = controller.displayedReviews[index];
                    return GestureDetector(
                      onTap: () {
                        // Displays the modal with review details
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) =>
                              reviewDetailModal.getReviewDetailModal(review, 0),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 2.0,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Left side content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'Brand: ${review.brand}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Reviewed by ${review.reviewerUsername}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        // Genre icon (male/female/unisex)
                                        if (review.genre == "Feminine")
                                          Icon(Icons.female,
                                              color: Colors.pink),
                                        if (review.genre == "Masculine")
                                          Icon(Icons.male, color: Colors.blue),
                                        if (review.genre == "Unisex")
                                          Icon(Icons.gesture,
                                              color: Colors.purple.shade400),

                                        SizedBox(width: 10),

                                        // Occasion icon (day/night/versatile)
                                        if (review.occasion == "Night")
                                          Icon(Icons.brightness_3,
                                              color: Colors.blueGrey),
                                        if (review.occasion == "Day")
                                          Icon(Icons.wb_sunny,
                                              color: Colors.orange.shade300),
                                        if (review.occasion == "Versatile")
                                          Icon(Icons.brightness_4,
                                              color: Colors.red.shade300),

                                        SizedBox(width: 10),

                                        // Longevity icon (low/moderate/high)
                                        Icon(
                                          Icons.access_time,
                                          color: review.longevity == "Short"
                                              ? Colors.red
                                              : review.longevity == "Moderate"
                                                  ? Colors.yellow.shade700
                                                  : Colors.green,
                                        ),

                                        SizedBox(width: 10),

                                        // Sillage icon (low/moderate/high)
                                        Icon(
                                          Icons.wifi_tethering,
                                          color: review.sillage == "Intimate"
                                              ? Colors.red
                                              : review.sillage == "Moderate"
                                                  ? Colors.yellow.shade700
                                                  : Colors.green,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Rating: ',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) => Icon(
                                              Icons.star,
                                              color:
                                                  index < review.overallRating
                                                      ? Colors.amber
                                                      : Colors.grey,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              ),

                              // Right side content
                              Container(
                                width: 125,
                                height: 125,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'No image found',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
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
                ),
              ),
              if (controller.hasMoreReviews ==
                  true) // Displays button only if there are more reviews
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: controller.loadMoreReviews,
                    child: Text('Load More'),
                  ),
                ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the review creation page
          Get.toNamed('create-review');
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
