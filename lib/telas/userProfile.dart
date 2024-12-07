import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/controllers/user_profile_controller.dart';

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
            physics:
                AlwaysScrollableScrollPhysics(), // Permite o gesto de refresh mesmo sem overflow
            child: Column(
              children: [
                SizedBox(height: 100),
                // Foto de perfil genérica
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
                        // Usando ListView.builder com shrinkWrap
                        ListView.builder(
                          shrinkWrap:
                              true, // Faz a lista ocupar apenas o espaço necessário
                          physics:
                              NeverScrollableScrollPhysics(), // Impede rolagem dentro do ListView
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
                                                // Exibe o ícone de gênero
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
                                            // Resto do layout
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
            if (controller.isOwnProfile == true)
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
                                        Get.back(); // Fecha o diálogo
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color:
                                                Colors.grey), // Contorno cinza
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14.0),
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 10), // Espaçamento entre os botões
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        controller.deleteReview(review);
                                        Get.back(); // Executa o método de logout
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.red, // Cor do botão
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
              ),
          ],
        ),
      ),
    );
  }
}
