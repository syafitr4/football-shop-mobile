import 'package:flutter/material.dart';
import 'package:football_shop/models/product_entry.dart';

// Ubah nama class jadi UpperCamelCase: ProductEntryCard
class ProductEntryCard extends StatelessWidget {
  final productEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    // PERBAIKAN: Akses via product.fields.thumbnail
                    product.fields.thumbnail, 
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title (Name)
                Text(
                  // PERBAIKAN: Akses via product.fields.name
                  product.fields.name, 
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Category
                // PERBAIKAN: Akses via product.fields.category
                Text('Category: ${product.fields.category}'),
                const SizedBox(height: 6),

                // Content preview (Description)
                Text(
                  // PERBAIKAN: Akses via product.fields.description
                  product.fields.description.length > 100
                      ? '${product.fields.description.substring(0, 100)}...'
                      : product.fields.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),

                // Featured indicator
                // PERBAIKAN: Akses via product.fields.isFeatured
                if (product.fields.isFeatured)
                  const Text(
                    'Featured',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}