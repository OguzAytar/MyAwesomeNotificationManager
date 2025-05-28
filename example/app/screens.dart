import 'package:flutter/material.dart';

/// Profil ekranı
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 Profil'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.green.shade100],
          ),
        ),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.green,
                ),
                SizedBox(height: 20),
                Text(
                  '🎉 Profil Sayfasına Hoş Geldiniz!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Bu sayfa profil bildirimine tıklandığında açılır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.green),
                          title: Text('Kullanıcı Adı'),
                          subtitle: Text('demo_user'),
                        ),
                        ListTile(
                          leading: Icon(Icons.email, color: Colors.green),
                          title: Text('E-posta'),
                          subtitle: Text('demo@example.com'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone, color: Colors.green),
                          title: Text('Telefon'),
                          subtitle: Text('+90 555 123 45 67'),
                        ),
                      ],
                    ),
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

/// Ayarlar ekranı
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ Ayarlar'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.orange.shade100],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.settings,
                  size: 120,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  '⚙️ Ayarlar Sayfası',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bu sayfa ayarlar bildirimine tıklandığında açılır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.notifications, color: Colors.orange),
                        title: const Text('Bildirimler'),
                        subtitle: const Text('Bildirim ayarlarını yönet'),
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Colors.orange,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.dark_mode, color: Colors.orange),
                        title: const Text('Karanlık Tema'),
                        subtitle: const Text('Tema ayarları'),
                        trailing: Switch(
                          value: false,
                          onChanged: (value) {},
                          activeColor: Colors.orange,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.language, color: Colors.orange),
                        title: const Text('Dil'),
                        subtitle: const Text('Türkçe'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.security, color: Colors.orange),
                        title: const Text('Güvenlik'),
                        subtitle: const Text('Güvenlik ayarları'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    ],
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

/// Marketing ekranı
class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final campaignId = args?['campaign_id'] ?? 'unknown';
    final discount = args?['discount'] ?? '0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Kampanya'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.purple.shade100],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_offer,
                  size: 120,
                  color: Colors.purple,
                ),
                const SizedBox(height: 20),
                const Text(
                  '🎯 Özel Kampanya!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Kampanya ID: $campaignId',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.purple.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          '%$discount İNDİRİM!',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tüm ürünlerde geçerli!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🛒 Alışverişe başlandı!'),
                                backgroundColor: Colors.purple,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'ALIŞVERİŞE BAŞLA',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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

/// Sistem ekranı
class SystemScreen extends StatelessWidget {
  const SystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final updateType = args?['update_type'] ?? 'general';

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔒 Sistem'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade50, Colors.red.shade100],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.security,
                  size: 120,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                const Text(
                  '🔒 Sistem Bildirimi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Güncelleme Türü: $updateType',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if (updateType == 'security') ...[
                          const Icon(
                            Icons.shield,
                            size: 60,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'GÜVENLİK GÜNCELLEMESİ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sisteminizin güvenliği için önemli güncellemeler mevcut.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ] else ...[
                          const Icon(
                            Icons.system_update,
                            size: 60,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'SİSTEM GÜNCELLEMESİ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sistem güncellemesi mevcut.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🔄 Güncelleme başlatıldı!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'GÜNCELLEMEYİ BAŞLAT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
