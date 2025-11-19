import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/shoplist_form.dart';
import 'package:football_shop/screens/product_entry_list.dart'; // 1. Import halaman list product

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  // Mapping nama -> warna
  Color _bgFor(String name) {
    switch (name.toLowerCase()) {
      case 'lihat daftar produk': // Sesuaikan dengan nama item di menu.dart
      case 'daftar produk':
      case 'all product': // Tambahkan variasi nama
        return Colors.blue;
      case 'create product':
      case 'tambah produk':
        return Colors.green;
      case 'logout':
        return Colors.red;
      default:
        return Theme.of(_ctx!).colorScheme.secondary; // fallback
    }
  }

  static BuildContext? _ctx; // trik kecil untuk akses Theme di _bgFor fallback

  @override
  Widget build(BuildContext context) {
    _ctx = context; // simpan context sementara
    final bg = _bgFor(item.name);
    const onBg = Colors.white;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Tampilkan SnackBar
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
            );

          final n = item.name.toLowerCase();

          // Navigasi ke Form Tambah Produk
          if (n == 'tambah produk' || n == 'create product' || n == 'add product') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          } 
          // 2. Navigasi ke Daftar Produk (GET)
          else if (n == 'lihat daftar produk' || n == 'daftar produk' || n == 'all product') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(),
              ),
            );
          }
          // Tambahkan kondisi Logout jika perlu
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