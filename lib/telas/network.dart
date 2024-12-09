import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/controllers/network_controller.dart';
import 'package:project_par_fans/reviewDetailModal.dart';

class Network extends GetView {
  final controller = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomnav.getBarraNav(1),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.reviews.isEmpty) {
          return Center(child: Text('No reviews available.'));
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshReviews(),
          child: SingleChildScrollView(
              physics:
                  AlwaysScrollableScrollPhysics(), // Permite o scroll mesmo sem conteúdo suficiente
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.reviews.length,
                    itemBuilder: (context, index) {
                      final review = controller.reviews[index];
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
                                reviewDetailModal.getReviewDetailModal(review),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          elevation: 2.0,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Coloca o conteúdo do texto à esquerda
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${review.reviewerUsername} reviewed ${review.name}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                // Coloca as estrelas à direita
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index < review.overallRating
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
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
                  if (controller.hasMoreReviews.value)
                    ElevatedButton(
                      onPressed: () => controller.fetchReviews(),
                      child: Text("Load More"),
                    ),
                ],
              )),
        );
      }),
    );
  }
}
