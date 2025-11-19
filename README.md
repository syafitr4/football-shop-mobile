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

# tugas2
## 1) Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?

Navigator.push() menambah halaman baru di atas stack sehingga pengguna bisa kembali dengan tombol “back”, sedangkan Navigator.pushReplacement() mengganti halaman sekarang sehingga halaman asal tidak bisa dikembalikan; di Football Shop, push() cocok untuk alur yang memang ingin bisa mundur (mis. dari daftar produk ke detail), sementara pushReplacement() pas untuk pindah dari menu/drawer atau layar “gateway” (mis. Home → Form tambah produk) agar tombol “back” tidak membawa pengguna ke layar perantara tadi.

## 2) Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Untuk konsistensi struktur, tiap halaman dibungkus Scaffold sebagai kerangka (punya AppBar, body, dan drawer), judul serta aksi ditempatkan di AppBar yang warnanya diambil dari tema, dan navigasi disatukan lewat Drawer yang diekstrak ke komponen LeftDrawer supaya semua layar berbagi pola header-drawer yang sama; hasilnya, tampilan terasa seragam di seluruh halaman

## 3) Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.

Pada tampilan form, Padding memberikan ruang antar-elemen agar rapi dan nyaman disentuh, SingleChildScrollView membolehkan konten digulir saat melebihi tinggi layar/ketika keyboard muncul sehingga tidak overflow, dan ListView dipakai untuk daftar item/menu yang panjang (termasuk di drawer) agar bisa digulir; kombinasi ini membuat form tetap terbaca dan adaptif di berbagai ukuran layar.

## 4) Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?

Identitas visual dijaga lewat ThemeData pada MaterialApp (mis. set colorScheme/primarySwatch sesuai warna brand), lalu komponen kunci seperti AppBar, tombol, dan kartu membaca warna dari Theme.of(context); hindari hard-code warna seperti Colors.indigo dan konsolidasikan ke tema, sehingga jika warna brand berubah cukup diubah sekali di tema dan konsisten tercermin di seluruh aplikasi.

# tugas3
## 1) Mengapa perlu membuat model Dart saat mengambil/mengirim data JSON
Ketika Flutter berkomunikasi dengan Django, data dikirim dan diterima dalam bentuk JSON. Di sisi Flutter, Dart adalah bahasa yang statically typed sehingga akan jauh lebih aman dan rapi kalau struktur JSON tersebut dipetakan ke dalam kelas model Dart, misalnya Product, User, atau Item. Dengan model, setiap field punya tipe yang jelas seperti String, int, bool, atau DateTime, sehingga kesalahan tipe bisa terdeteksi saat compile time dan IDE dapat membantu memberikan auto-complete serta peringatan jika ada field yang belum di-handle. Model juga memaksa kita mendefinisikan mana field yang boleh null dan mana yang wajib terisi, sehingga null-safety lebih terjaga. Jika kita hanya memakai Map<String, dynamic> tanpa model, maka semua key berupa string bebas dan semua value bertipe dynamic, yang berarti kita harus mengingat nama key secara manual, melakukan cast sendiri, dan menambahkan pengecekan null di mana-mana; hal ini rawan typo, rawan runtime error, dan ketika struktur JSON berubah maka kita harus mencari dan mengubah semua pemakaian key tersebut di seluruh proyek. Dengan model Dart, perubahan struktur data cukup dilakukan di satu tempat dan otomatis terpropagasi ke seluruh kode, sehingga maintainability dan konsistensi aplikasi menjadi jauh lebih baik.

## 2) Fungsi package http dan CookieRequest
Dalam tugas ini, package http digunakan sebagai klien HTTP umum untuk melakukan request seperti GET dan POST ke backend Django tanpa mengikatkan diri ke konsep session atau cookie tertentu. Biasanya http dipakai untuk endpoint yang bersifat publik atau saat kita hanya perlu mengambil atau mengirim JSON tanpa perlu menyimpan status login. Sementara itu, CookieRequest dari package pbp_django_auth berperan sebagai klien HTTP yang “paham” mekanisme autentikasi Django berbasis session dan cookie. CookieRequest otomatis menyimpan cookie yang diterima dari Django (misalnya sessionid) dan mengirimkannya kembali pada request berikutnya, serta menyediakan fungsi siap pakai seperti login, logout, dan postJson yang sudah terintegrasi dengan alur autentikasi Django. Dengan kata lain, http lebih rendah level dan netral, sedangkan CookieRequest lebih spesifik untuk skenario di mana kita ingin menjaga status login dan menggunakan sistem autentikasi bawaan Django.

## 3) Mengapa instance CookieRequest perlu dibagikan ke semua komponen Flutter
Instance CookieRequest perlu dibagikan ke seluruh komponen Flutter karena objek inilah yang menyimpan cookie dan status autentikasi user. Ketika user berhasil login, Django mengirim cookie session ke client dan CookieRequest menyimpan cookie tersebut di memorinya. Jika setiap halaman atau widget membuat instance CookieRequest sendiri-sendiri, cookie yang tersimpan di satu instance tidak akan diketahui oleh instance lain, sehingga saat berpindah halaman aplikasi akan terlihat seperti “lupa” bahwa user sudah login dan request ke endpoint terproteksi bisa dibaca sebagai anonimus. Dengan membagikan satu instance CookieRequest secara global, misalnya melalui Provider atau mekanisme dependency injection lain, semua halaman akan menggunakan “jar cookie” yang sama sehingga status login konsisten di seluruh aplikasi. Pendekatan ini mirip seperti satu browser yang menyimpan cookie dan mengirimkannya di setiap permintaan ke server yang sama, sehingga identitas user tetap dikenali selama sesi masih aktif.

## 4) Konfigurasi konektivitas Flutter–Django
Agar Flutter yang berjalan di emulator Android dapat berkomunikasi dengan Django di laptop, ada beberapa konfigurasi yang harus diatur. Pertama, kita perlu menambahkan 10.0.2.2 ke ALLOWED_HOSTS di settings.py Django, karena dari perspektif emulator, alamat 10.0.2.2 adalah “alias” untuk localhost mesin host. Jika alamat ini tidak diizinkan, Django akan menolak request dengan error “DisallowedHost”. Kedua, kita perlu mengaktifkan CORS dan mengkonfigurasinya dengan benar sehingga permintaan dari origin aplikasi (nanti ketika di-deploy atau jika diakses dari domain berbeda) tidak diblokir oleh browser atau environment karena dianggap cross-origin yang tidak diizinkan. Ketiga, pengaturan cookie dan atribut seperti SameSite dan opsi berkaitan session perlu disesuaikan, supaya cookie sesi tetap dikirim pada request Flutter yang relevan dan autentikasi Django bisa berjalan; jika pengaturannya terlalu ketat atau tidak sesuai, cookie bisa saja tidak terkirim sehingga user dianggap belum login setiap kali request baru. Keempat, di sisi Android kita wajib menambahkan permission akses internet di AndroidManifest.xml; tanpa ini, aplikasi tidak akan bisa membuka koneksi HTTP sama sekali dan request akan gagal dengan error jaringan. Jika salah satu konfigurasi tersebut hilang atau salah, gejalanya bisa berupa tidak bisa connect ke server, permintaan selalu gagal, Django menolak host, sampai status login yang tidak pernah “nempel” karena cookie tidak tersimpan atau tidak ikut terkirim.

## 5) Mekanisme pengiriman data dari input hingga ditampilkan di Flutter
Alur pengiriman data secara umum dimulai ketika user memasukkan input pada form di Flutter, misalnya melalui TextFormField dan widget serupa. Setelah user menekan tombol submit, aplikasi mengumpulkan nilai dari field tersebut dan membentuk objek model Dart atau map yang kemudian diserialisasi menjadi JSON. Flutter lalu mengirim request HTTP (misalnya POST) ke endpoint Django dengan JSON ini sebagai body. Django menerima request, memetakan path ke view yang sesuai, mem-parsing body JSON, melakukan validasi, dan jika valid, menyimpan atau memproses data sesuai kebutuhan (misalnya menyimpan ke database melalui model Django). Setelah operasi selesai, Django mengirim response kembali dalam bentuk JSON yang berisi status dan, jika perlu, data yang sudah diperbarui. Di sisi Flutter, response ini diterima, body JSON di-decode menjadi model Dart, lalu state UI diperbarui—misalnya daftar item dimasukkan ke dalam List model dan ditampilkan menggunakan ListView.builder. Karena proses ini berjalan secara asinkron, Flutter biasanya menggunakan Future, async/await, atau FutureBuilder untuk menunggu hasil sebelum merender tampilan yang sesuai, sehingga pengguna bisa melihat loading indicator dan kemudian melihat data terbaru setelah request selesai.

## 6) Mekanisme autentikasi login, register, dan logout
Untuk autentikasi, alurnya dimulai dari halaman register dan login di Flutter. Saat register, user mengisi data akun seperti username dan password, lalu Flutter mengirim request POST ke endpoint register Django dengan data tersebut. Django memvalidasi input, membuat pengguna baru dengan menyimpan password yang sudah di-hash, dan mengembalikan response JSON yang menandakan apakah pendaftaran berhasil atau tidak. Setelah itu user biasanya diarahkan ke halaman login. Pada saat login, user mengisi username dan password di Flutter, kemudian aplikasi memanggil CookieRequest.login atau endpoint serupa yang akan mengirim permintaan ke Django. Django menggunakan fungsi authenticate untuk memeriksa kecocokan username dan password, lalu jika benar memanggil login sehingga Django membuat session baru di server dan mengirimkan cookie session ke client. CookieRequest menyimpan cookie ini sehingga request-request berikutnya otomatis membawa session ID yang sama, dan Django pada sisi server akan mengenali bahwa permintaan tersebut berasal dari user yang sudah login. Setelah login sukses, Flutter mengubah state aplikasi (misalnya menyimpan informasi bahwa user sudah login) dan menavigasi ke halaman menu utama. Untuk logout, Flutter memanggil endpoint logout Django melalui CookieRequest, lalu Django akan menghapus session di server dan menginstruksikan client untuk menghapus cookie terkait; CookieRequest juga membersihkan cookie yang disimpan. Setelah logout selesai, Flutter menampilkan halaman login kembali dan user tidak bisa mengakses endpoint yang membutuhkan autentikasi sampai login lagi.

## 7) Implementasi checklist secara step-by-step
Dalam mengerjakan checklist, saya tidak hanya menyalin tutorial, tetapi menerapkannya secara bertahap di proyek sendiri. Pertama, saya memastikan backend Django sudah memiliki model dan view yang benar, kemudian saya menambahkan endpoint yang mengembalikan data dalam bentuk JSON, termasuk endpoint khusus untuk login, register, dan logout yang mengembalikan status serta pesan sederhana agar mudah di-handle oleh Flutter. Setelah itu saya mengatur konfigurasi ALLOWED_HOSTS, menambahkan 10.0.2.2, menginstal dan mengkonfigurasi CORS, serta menyesuaikan pengaturan session dan cookie supaya request dari emulator Android dan dari aplikasi yang sudah login dapat diterima dengan benar. Di sisi Flutter, saya memulai dengan menambahkan dependency pbp_django_auth dan membuat satu instance CookieRequest di atas MaterialApp, misalnya menggunakan Provider, sehingga instance tersebut bisa diakses di seluruh halaman. Saya kemudian membuat model Dart untuk data yang dikirim dan diterima dari Django, menulis konstruktor fromJson dan toJson, lalu mengganti penggunaan Map<String, dynamic> langsung dengan kelas model ini. Berikutnya, saya membuat halaman login dan register di Flutter, menghubungkannya dengan fungsi login dan endpoint register, serta menambahkan logika untuk menampilkan pesan error atau mengarahkan ke menu utama jika autentikasi berhasil. Setelah autentikasi berfungsi, saya membuat halaman untuk menampilkan data dari Django menggunakan request GET yang memanfaatkan CookieRequest atau http, mem-parsing JSON ke dalam list model Dart, dan menampilkannya di UI. Terakhir, saya menambahkan form untuk mengirim data baru ke Django, menghubungkan tombol submit dengan request POST, lalu menguji seluruh alur dari register, login, melihat data, menambah data, hingga logout untuk memastikan semua langkah checklist berjalan end-to-end tanpa error.