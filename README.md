# tugas1
## 1) Apa itu widget tree & hubungan parent–child?

Widget tree adalah struktur hierarki yang menyusun UI Flutter. Akar (root) biasanya widget yang diberikan ke runApp(...), lalu bercabang ke child, grandchild, dst.
Parent ke child bekerja lewat tiga arus utama:

1. Konfigurasi & constraints turun: parent memberi constraints (ukuran/aturan layout) dan konfigurasi (mis. tema).
2. Ukuran & layout naik: child menghitung ukuran/posisi lalu “melapor” ke parent.
3. Event & data mengalir: data state/inherited (mis. Theme, MediaQuery) bisa diakses child lewat BuildContext.
Ketika ada perubahan, Flutter merekonstruksi sub-tree yang terdampak (rebuild), bukan seluruh pohon  ini yang bikin UI efisien.



## 2) Semua widget yang dipakai & fungsinya

MaterialApp (di main.dart): pembungkus aplikasi Material; nyediain routing, theme, localization.
Scaffold: kerangka halaman Material (punya AppBar, body, SnackBar, dll).
AppBar: bar atas halaman (judul, aksi).
Padding: memberi jarak di sekeliling child.
Column / Row: layout vertikal / horizontal.
Center: memusatkan child di dalamnya.
Card: kartu Material dengan elevasi (dipakai di InfoCard).
Container: kotak serbaguna (ukuran, padding, dekorasi).
Text: menampilkan teks.
SizedBox: memberi jarak tetap.
GridView.count: membuat grid dengan jumlah kolom tetap (3 kolom untuk menu).
Icon: menampilkan ikon Material.
Material: memberi material surface (warna, radius) untuk efek ink.
InkWell: area yang bisa ditekan, memunculkan ripple.
SnackBar: notifikasi singkat di bawah layar
MediaQuery: akses ukuran layar, dsb.
Custom:
InfoCard: kartu ringkas NPM/Name/Class.
ItemHomepage: model sederhana (nama & ikon).
ItemCard: tombol menu grid (All/My/Create Product) dengan warna berbeda.



## 3) Fungsi MaterialApp & kenapa sering jadi root

Mengaktifkan Material Design: tema (ThemeData), warna, font default Material.
Menyediakan Navigator & routes, localization, title, debug banner control, dsb.
Dijadikan root karena banyak widget Material (mis. Scaffold, SnackBar, Theme.of(...)) mengandalkan inherited widgets yang disediakan MaterialApp. Tanpa ini, komponen Material tidak akan berfungsi lengkap.



## 4) Perbedaan StatelessWidget vs StatefulWidget & kapan dipilih?

StatelessWidget

Immutabel: tidak punya state internal yang berubah-ubah.
Build bergantung sepenuhnya pada input (props) dan inherited context.
Pilih ini untuk UI statis/presentasional: ikon + teks, kartu info, tombol yang hanya memicu aksi.
StatefulWidget

Memiliki state yang hidup di objek State, bisa berubah via setState(...).
Cocok untuk input/form, animasi, counter, async loading, toggle, dll.
Pilih ini saat UI perlu bereaksi terhadap interaksi/stream data & mempertahankan nilai di antara rebuild.




## 5) Apa itu BuildContext & penggunaannya di build?

BuildContext adalah handle posisi widget di dalam widget tree.
Penting karena:

Dipakai untuk mengakses inherited widgets (mis. Theme.of(context), MediaQuery.of(context), Navigator.of(context), ScaffoldMessenger.of(context)).
Menentukan scope: context untuk ScaffoldMessenger/Navigator harus berada di bawah Scaffold/MaterialApp yang relevan.


## 6) Hot reload vs hot restart

Hot reload

Menyuntikkan perubahan kode tanpa mengulang aplikasi dari awal.
State StatefulWidget dipertahankan, lalu Flutter me-rebuild UI yang terdampak.
Cepat untuk iterasi tampilan & logika build.

Hot restart

Mengulang aplikasi dari main() seluruh state hilang (seperti fresh start).
Dipakai saat perubahan memengaruhi inisialisasi awal, global state, atau jika hot reload tidak cukup (mis. error karena static initialization).