import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const ContentSharingApp());
}

class ContentSharingApp extends StatelessWidget {
  const ContentSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0A2540),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  int _tabIndex = 1;

  final List<_Contact> _contacts = [
    _Contact('Ayu', 'Mutual', Colors.pink, phone: '0812-1111-2222'),
    _Contact('Bima', 'Teman', Colors.indigo, phone: '0857-3333-4444'),
    _Contact('Citra', 'Teman', Colors.orange, phone: '0821-5555-6666'),
    _Contact('Dio', 'Kontak', Colors.green, phone: '0813-7777-8888'),
    _Contact('Eka', 'Mutual', Colors.blue, phone: '0878-9999-0000'),
    _Contact('Fina', 'Kontak', Colors.purple, phone: '0896-1234-5678'),
  ];
  final List<_Post> _posts = [
    _Post(
      user: 'Rani',
      caption: 'Sunset vibes',
      colors: [Color(0xFF0A2540), Color(0xFF1B3B6F)],
    ),
    _Post(
      user: 'Yoga',
      caption: 'Ngopi sore',
      colors: [Color(0xFF1B3B6F), Color(0xFF3D5A80)],
    ),
    _Post(
      user: 'Lia',
      caption: 'Workout day',
      colors: [Color(0xFF0A2540), Color(0xFF3D5A80)],
    ),
    _Post(
      user: 'Andi',
      caption: 'Jalan-jalan',
      colors: [Color(0xFF0A2540), Color(0xFF577590)],
    ),
    _Post(
      user: 'Sari',
      caption: 'Book time',
      colors: [Color(0xFF0A2540), Color(0xFF6C8EBF)],
    ),
    _Post(
      user: 'Dimas',
      caption: 'Coding mode',
      colors: [Color(0xFF0A2540), Color(0xFF5E60CE)],
    ),
    _Post(
      user: 'Naya',
      caption: 'Music on',
      colors: [Color(0xFF0A2540), Color(0xFF4361EE)],
    ),
    _Post(
      user: 'Tono',
      caption: 'Chill weekend',
      colors: [Color(0xFF0A2540), Color(0xFF4895EF)],
    ),
  ];

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImage = File(photo.path);
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        _selectedImage = File(img.path);
      });
    }
  }

  Future<void> _shareContent() async {
    if (_selectedImage != null) {
      await Share.shareXFiles([
        XFile(_selectedImage!.path),
      ], text: 'Lihat konten baru saya!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ambil foto dulu ya sebelum sharing!')),
      );
    }
  }

  Future<void> _shareToContact(_Contact c) async {
    if (_selectedImage != null) {
      await Share.shareXFiles([
        XFile(_selectedImage!.path),
      ], text: 'Untuk ${c.name} (${c.phone})');
    } else {
      await Share.share('Untuk ${c.name} (${c.phone})');
    }
  }

  void _openComposeSheet(_Contact c) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: c.color.withOpacity(0.2),
                  child: Text(
                    c.initial,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(c.name),
                subtitle: Text('${c.tag} • ${c.phone}'),
              ),
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _selectedImage!,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Belum ada gambar',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () async {
                        await _pickFromGallery();
                        if (mounted) setState(() {});
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('Galeri'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () async {
                        await _takePicture();
                        if (mounted) setState(() {});
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Kamera'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    await _shareToContact(c);
                    if (mounted) Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openAddContactSheet() {
    final nameC = TextEditingController();
    final phoneC = TextEditingController();
    String tag = 'Kontak';
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameC,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: phoneC,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No. HP',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: tag,
                items: const [
                  DropdownMenuItem(value: 'Kontak', child: Text('Kontak')),
                  DropdownMenuItem(value: 'Teman', child: Text('Teman')),
                  DropdownMenuItem(value: 'Mutual', child: Text('Mutual')),
                ],
                onChanged: (v) => tag = v ?? 'Kontak',
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  prefixIcon: Icon(Icons.label),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    final name = nameC.text.trim();
                    final phone = phoneC.text.trim();
                    if (name.isEmpty || phone.isEmpty) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nama dan nomor harus diisi'),
                        ),
                      );
                      return;
                    }
                    final palette = [
                      Colors.teal,
                      Colors.indigo,
                      Colors.pink,
                      Colors.orange,
                      Colors.green,
                      Colors.blue,
                      Colors.purple,
                      Colors.cyan,
                    ];
                    final color = palette[_contacts.length % palette.length];
                    setState(() {
                      _contacts.add(_Contact(name, tag, color, phone: phone));
                    });
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Kontak'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 64,
              title: const Text(
                'FlowShare',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: _shareContent,
                  icon: const Icon(Icons.share),
                ),
              ],
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0A2540), Color(0xFF1B3B6F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const TabBar(
                    isScrollable: false,
                    tabs: [
                      Tab(icon: Icon(Icons.explore), text: 'FYP'),
                      Tab(icon: Icon(Icons.camera_alt), text: 'Kamera'),
                      Tab(icon: Icon(Icons.photo_library), text: 'Galeri'),
                      Tab(icon: Icon(Icons.chat_bubble), text: 'Chats'),
                    ],
                    labelPadding: EdgeInsets.symmetric(horizontal: 12),
                    indicatorColor: Colors.white,
                  ),
                ),
              ),
            ),
            body: NotificationListener<ScrollNotification>(
              onNotification: (_) => false,
              child: TabBarView(
                children: [
                  _buildFypTab(),
                  _buildCameraTab(),
                  _buildGalleryTab(),
                  _buildChatsTab(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera_alt),
            ),
            bottomNavigationBar: _selectedImage == null
                ? null
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '1 gambar siap dibagikan',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            DefaultTabController.of(context).animateTo(2);
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Pilih Kontak'),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildFypTab() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _posts.length,
      itemBuilder: (context, i) {
        final p = _posts[i];
        return Stack(
          fit: StackFit.expand,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: p.colors,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
            Positioned(
              right: 16,
              bottom: 32,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    child: const Icon(Icons.favorite, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    child: const Icon(Icons.comment, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      if (_selectedImage != null) {
                        await Share.shareXFiles([
                          XFile(_selectedImage!.path),
                        ], text: p.caption);
                      } else {
                        await Share.share('FYP: ${p.caption}');
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.15),
                      child: const Icon(Icons.share, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              bottom: 24,
              right: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${p.user}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(p.caption, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCameraTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: _selectedImage == null
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.12),
                            Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.12),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 72,
                              color: Colors.black54,
                            ),
                            SizedBox(height: 12),
                            Text('Ketuk tombol kamera untuk mengambil foto'),
                          ],
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(_selectedImage!, fit: BoxFit.contain),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera_enhance),
                  label: const Text('Ambil Foto'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pilih dari Galeri'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: _selectedImage == null
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image, size: 72, color: Colors.black54),
                            SizedBox(height: 12),
                            Text('Belum ada gambar terpilih'),
                          ],
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.file(_selectedImage!, fit: BoxFit.contain),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _pickFromGallery,
            icon: const Icon(Icons.photo),
            label: const Text('Pilih Gambar'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _selectedImage == null
                ? null
                : () => DefaultTabController.of(context).animateTo(2),
            icon: const Icon(Icons.send),
            label: const Text('Kirim ke Kontak'),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsTab() {
    return Column(
      children: [
        const SizedBox(height: 8),
        SizedBox(
          height: 84,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _contacts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final c = _contacts[i];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: c.color.withOpacity(0.2),
                    child: Text(
                      c.initial,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(c.name, style: const TextStyle(fontSize: 12)),
                ],
              );
            },
          ),
        ),
        const Divider(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: _openAddContactSheet,
              icon: const Icon(Icons.person_add),
              label: const Text('Tambah Kontak'),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _contacts.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final c = _contacts[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: c.color.withOpacity(0.15),
                  child: Text(c.initial),
                ),
                title: Text(c.name),
                subtitle: Text('${c.tag} • ${c.phone}'),
                trailing: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _openComposeSheet(c),
                ),
                onTap: () => _openComposeSheet(c),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Contact {
  final String name;
  final String tag;
  final Color color;
  final String phone;
  const _Contact(this.name, this.tag, this.color, {this.phone = ''});
  String get initial => name.isNotEmpty ? name[0] : '?';
}

class _Post {
  final String user;
  final String caption;
  final List<Color> colors;
  const _Post({
    required this.user,
    required this.caption,
    required this.colors,
  });
}
