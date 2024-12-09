import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/controllers/user_profile_controller.dart';
import 'package:project_par_fans/reviewDetailModal.dart';

class Userprofile extends GetView<UserProfileController> {
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomnav.getBarraNav(2),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshUserProfile();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 100),
                // Foto de perfil
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/user_placeholder.png'),
                ),
                SizedBox(height: 10),
                // Nome de usuário
                Text(
                  controller.user.value?.username as String,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                // Contagem de seguidores e seguidos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navegar para a lista de seguidores
                      },
                      child: Text(
                        '${controller.followerCount.toString()} Followers',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        // Navegar para a lista de seguidos
                      },
                      child: Text(
                        '${controller.followingCount.toString()} Following',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Exibindo os reviews
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.displayedReviews.isEmpty) {
                    return Center(child: Text('No reviews available.'));
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.displayedReviews.length,
                          itemBuilder: (context, index) {
                            final review = controller.displayedReviews[index];
                            return GestureDetector(
                              onTap: () {
                                // Exibe o modal de detalhes do review
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) =>
                                      reviewDetailModal.getReviewDetailModal(
                                          review, 1, controller),
                                );
                              },
                              child: Card(
                                margin: EdgeInsets.all(8.0),
                                elevation: 2.0,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  review.name,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  'Brand: ${review.brand}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                // Genre icon (Feminine/Masculine/Unisex)
                                                if (review.genre == "Feminine")
                                                  Icon(Icons.female,
                                                      color: Colors.pink),
                                                if (review.genre == "Masculine")
                                                  Icon(Icons.male,
                                                      color: Colors.blue),
                                                if (review.genre == "Unisex")
                                                  Icon(Icons.gesture,
                                                      color: Colors
                                                          .purple.shade400),

                                                SizedBox(width: 10),

                                                // Occasion icon (day/night/versatile)
                                                if (review.occasion == "Night")
                                                  Icon(Icons.brightness_3,
                                                      color: Colors.blueGrey),
                                                if (review.occasion == "Day")
                                                  Icon(Icons.wb_sunny,
                                                      color: Colors
                                                          .orange.shade300),
                                                if (review.occasion ==
                                                    "Versatile")
                                                  Icon(Icons.brightness_4,
                                                      color:
                                                          Colors.red.shade300),

                                                SizedBox(width: 10),

                                                // Longevity icon (low/moderate/high)
                                                Icon(
                                                  Icons.access_time,
                                                  color: review.longevity ==
                                                          "Short"
                                                      ? Colors.red
                                                      : review.longevity ==
                                                              "Moderate"
                                                          ? Colors
                                                              .yellow.shade700
                                                          : Colors.green,
                                                ),

                                                SizedBox(width: 10),

                                                // Sillage icon (low/moderate/high)
                                                Icon(
                                                  Icons.wifi_tethering,
                                                  color: review.sillage ==
                                                          "Intimate"
                                                      ? Colors.red
                                                      : review.sillage ==
                                                              "Moderate"
                                                          ? Colors
                                                              .yellow.shade700
                                                          : Colors.green,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (controller.hasMoreReviews == true)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: controller.loadMoreReviews,
                              child: Text('Load More'),
                            ),
                          ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
