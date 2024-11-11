import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:long_register_flutter/model/products/products.dart';
import 'package:long_register_flutter/model_view_model/product_controller.dart';

class AddCard extends StatefulWidget {
  AddCard({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Cart"),
      ),
      body: Obx(() { // Use Obx to rebuild when cartItems changes
        if (widget.productController.cartItems.isEmpty) {
          return Center(child: Text("Your cart is empty"));
        }
        return ListView.builder(
          itemCount: widget.productController.cartItems.length,
          itemBuilder: (context, index) {
            var product = widget.productController.cartItems[index];
            return ProductCard(
              product: product,
              onRemove: () {
                // Logic to remove the product from cart
                print("${product.title} removed from cart");
                widget.productController.cartItems.remove(product); // Remove from cart
              },
            );
          },
        );
      }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product; // Assuming Product is a model class containing details
  final VoidCallback onRemove;

  const ProductCard({
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              product.thumbnail ?? "",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product.price != null ? (product.price! * product.quantity).toStringAsFixed(2) : "0.00"}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${product.quantity}', // Display the quantity directly from the product
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 16),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: onRemove,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

