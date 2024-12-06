import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/home_controller.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/telas/userProfile.dart';

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
                        // Exibe o modal com os detalhes do review
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
                              Row(
                                children: [
                                  // Ícone de sexo (masculino/feminino)
                                  if (review.notaCompartilhavel == "Feminine")
                                    Icon(Icons.female, color: Colors.pink),
                                  if (review.notaCompartilhavel == "Masculine")
                                    Icon(Icons.male, color: Colors.blue),
                                  if (review.notaCompartilhavel == "Unissex")
                                    Icon(Icons.gesture,
                                        color: Colors.purple.shade400),

                                  SizedBox(width: 10),

                                  // Ícone de ocasião (dia/noite)
                                  if (review.notaOcasiao == "night")
                                    Icon(Icons.brightness_3,
                                        color: Colors.blueGrey),
                                  if (review.notaOcasiao == "day")
                                    Icon(Icons.wb_sunny,
                                        color: Colors.orange.shade300),
                                  if (review.notaOcasiao == "versatile")
                                    Icon(Icons.brightness_4,
                                        color: Colors.red.shade300),
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
                                        color: index < review.notaGeral
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
                      ),
                    );
                  },
                ),
              ),
              if (controller.hasMoreReviews ==
                  true) // Exibe botão apenas se há mais reviews
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
          // Navega para a página de criação de reviews
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Text('Notas:', style: TextStyle(fontSize: 20)),
          SizedBox(height: 8.0),
          Text('- Compartilhável: ${review.notaCompartilhavel}'),
          Text('- Estação: ${review.notaEstacao}'),
          Text('- Geral: ${review.notaGeral}'),
          Text('- Ocasião: ${review.notaOcasiao}'),
          SizedBox(height: 16.0),
          Text(
            'Review by: ${review.reviewerUsername}',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Redireciona para o perfil do usuário
                Get.to(() => UserProfile(), arguments: review.reviewerId);
              },
              child: Text('View Profile'),
            ),
          ),
        ],
      ),
    );
  }
}
