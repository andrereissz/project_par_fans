import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/controllers/home_controller.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/telas/reviewerProfile.dart';

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
                              _buildReviewDetailsModal(review),
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

  Widget _buildReviewDetailsModal(PerfumeReview review) {
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
            Align(
              alignment: Alignment.center,
              child: Text(
                'Reviewed by: ${review.reviewerUsername}',
                style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey),
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ReviewerProfile(), arguments: review.reviewerId);
                },
                child: Text('View Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
