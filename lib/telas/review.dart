import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_par_fans/creave_review_controller.dart';

class CreatePerfumeReviewScreen extends GetView<CreatePerfumeReviewController> {
  @override
  final controller = Get.put(CreatePerfumeReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        title: Text("Make a Review"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: "Fragrance Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.brandController,
              decoration: InputDecoration(
                labelText: "Fragrance Brand",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Compartilhável",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["Feminine", "Unissex", "Masculine"]
                      .map(
                        (value) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: value,
                              groupValue:
                                  controller.selectedCompartilhavel.value,
                              onChanged: (val) {
                                controller.selectedCompartilhavel.value = val!;
                              },
                            ),
                            Text(value),
                          ],
                        ),
                      )
                      .toList(),
                )),
            SizedBox(height: 16),
            Text(
              "Estação",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["spring", "summer", "fall", "winter"]
                      .map(
                        (value) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: value,
                              groupValue: controller.selectedEstacao.value,
                              onChanged: (val) {
                                controller.selectedEstacao.value = val!;
                              },
                            ),
                            Text(value),
                          ],
                        ),
                      )
                      .toList(),
                )),
            SizedBox(height: 16),
            Text(
              "Ocasião",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["day", "versatile", "night"]
                      .map(
                        (value) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: value,
                              groupValue: controller.selectedOcasiao.value,
                              onChanged: (val) {
                                controller.selectedOcasiao.value = val!;
                              },
                            ),
                            Text(value),
                          ],
                        ),
                      )
                      .toList(),
                )),
            SizedBox(height: 16),
            Text(
              "Nota Geral",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => RatingBar.builder(
                  initialRating: controller.notaGeral.value,
                  minRating: 1,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    controller.notaGeral.value = rating;
                  },
                )),
            SizedBox(height: 48),
            Center(
              child: ElevatedButton(
                onPressed: controller.saveReview,
                child: Text(
                  "Save Review",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
