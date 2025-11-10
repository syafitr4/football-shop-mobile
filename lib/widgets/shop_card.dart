import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/shoplist_form.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  // Mapping nama -> warna (case-insensitive + beberapa sinonim)
  Color _bgFor(String name) {
    switch (name.toLowerCase()) {
      case 'all product':
        return Colors.blue;
      case 'my product':
        return Colors.green;
      case 'create product':
        return Colors.red;
      default:
        return Theme.of(_ctx!).colorScheme.secondary; // fallback
    }
  }

  static BuildContext? _ctx; // trik kecil untuk akses Theme di _bgFor fallback

  @override
  Widget build(BuildContext context) {
    _ctx = context; // simpan context sementara untuk fallback theme
    final bg = _bgFor(item.name);
    const onBg = Colors.white;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );
          // Arahkan untuk Create/Add Product
          final n = item.name.toLowerCase();
          if (n == 'add product' || n == 'create product') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductFormPage(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: onBg, size: 30),
                const SizedBox(height: 3),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: onBg),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
