import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:long_register_flutter/model/products/products.dart';
import 'package:long_register_flutter/model_view_model/product_controller.dart';

class ListProduct extends StatefulWidget {
  ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

final ProductController productController = Get.put(ProductController());

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.loadingProduct.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      }
      return Container(
        child: ListView.builder(
          itemCount: productController.products.length,
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var product = productController.products[index];
            return Container(
              height: 150, // Adjust height as needed
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            product.thumbnail ?? "",
                            height: 30,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            product.title ?? "",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Increment quantity before adding to cart
                              productController.cartItems.add(product);
                              product.quantity; // Increment the product's quantity

                              productController.printProductDetails(product);
                            },
                            child: Text("Add+"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

extension on List<Products> {
  set quantity(quantity) {}
}

