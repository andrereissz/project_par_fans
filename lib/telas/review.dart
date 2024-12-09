import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_par_fans/controllers/creave_review_controller.dart';

class CreatePerfumeReviewScreen extends GetView<CreatePerfumeReviewController> {
  @override
  final controller = Get.put(CreatePerfumeReviewController());
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
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
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      Get.snackbar(
                        'Photo Taken',
                        'Image path: ${image.path}',
                        snackPosition: SnackPosition.TOP,
                        snackStyle: SnackStyle.GROUNDED,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Take a Photo",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Feminine", "Unisex", "Masculine"]
                        .map(
                          (value) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: controller.selectedGenre.value,
                                onChanged: (val) {
                                  controller.selectedGenre.value = val!;
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
                "Ideal Season",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Spring", "Summer", "Fall", "Winter"]
                        .map(
                          (value) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: controller.selectedSeason.value,
                                onChanged: (val) {
                                  controller.selectedSeason.value = val!;
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
                "Occasion",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Day", "Versatile", "Night"]
                        .map(
                          (value) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: controller.selectedOccasion.value,
                                onChanged: (val) {
                                  controller.selectedOccasion.value = val!;
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
                "Longevity",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Short", "Moderate", "Long"]
                        .map(
                          (value) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: controller.selectedLongevity.value,
                                onChanged: (val) {
                                  controller.selectedLongevity.value = val!;
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
                "Sillage",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["Intimate", "Moderate", "Strong"]
                        .map(
                          (value) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: value,
                                groupValue: controller.selectedSillage.value,
                                onChanged: (val) {
                                  controller.selectedSillage.value = val!;
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
                    initialRating: controller.overallRating.value,
                    minRating: 1,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.overallRating.value = rating;
                    },
                  )),
              SizedBox(height: 16),
              Text(
                "Comment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: controller.commentController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Write your comment here",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
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
      ),
    );
  }
}
