import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:savora_app/features/customer/auth/screens/login_screen.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../../providers/auth_provider.dart';

class DriverProfileScreen extends ConsumerWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: cs.surface,

      // 🔥 Cleaner AppBar (premium feel)
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          // ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: cs.outline.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: cs.primary.withOpacity(0.12),
                  child: Icon(
                    Icons.person,
                    size: 44,
                    color: cs.primary,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'John Doe',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Driver • Active',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 12),

                // Rating pill
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded,
                          color: cs.primary, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '4.9',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '/ 5.0',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          _SectionHeader(title: 'Account'),

          _SectionCard(children: [
            _ProfileMenuItem(
              icon: Icons.directions_car_outlined,
              title: 'Vehicle Information',
              subtitle: 'Toyota Prius • ABC-1234',
            ),
            Divider(color: cs.outline.withOpacity(0.2)),
            _ProfileMenuItem(
              icon: Icons.credit_card_outlined,
              title: 'Payout Methods',
              subtitle: 'Bank account connected',
            ),
            Divider(color: cs.outline.withOpacity(0.2)),
            _ProfileMenuItem(
              icon: Icons.shield_outlined,
              title: 'Security',
              subtitle: 'Password & verification',
            ),
          ]),

          const SizedBox(height: 20),

          _SectionHeader(title: 'Preferences'),

          _SectionCard(children: [
             _ThemeToggleTile(),
            Divider(color: cs.outline.withOpacity(0.2)),
            _ProfileMenuItem(
              icon: Icons.navigation_outlined,
              title: 'Navigation',
              subtitle: 'Google Maps',
            ),
            Divider(color: cs.outline.withOpacity(0.2)),
            _ProfileMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              subtitle: 'Enabled',
            ),
          ]),

          const SizedBox(height: 20),

          _SectionHeader(title: 'Support'),

          _SectionCard(children: [
            _ProfileMenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help Center',
            ),
          ]),

          const SizedBox(height: 28),

          // ================= LOGOUT =================
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                foregroundColor: cs.error,
                side: BorderSide(color: cs.error.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant.withOpacity(0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _ThemeToggleTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    // Uses the main project's themeModeNotifier for consistency
    final isLight = themeModeNotifier.value == ThemeMode.light;

    return SwitchListTile(
      value: isLight,
      onChanged: (value) {
        themeModeNotifier.value =
            value ? ThemeMode.light : ThemeMode.dark;
      },
      activeColor: cs.onPrimary,
      activeTrackColor: cs.primary,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isLight ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          color: cs.onSurfaceVariant,
        ),
      ),
      title: Text(isLight ? 'Light Mode' : 'Dark Mode',
          style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      subtitle: Text(
          isLight ? 'Premium light theme active' : 'Dark theme active',
          style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _ProfileMenuItem(
      {required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: cs.onSurfaceVariant),
      ),
      title: Text(title,
          style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant))
          : null,
      trailing: Icon(Icons.chevron_right_rounded, color: cs.outline),
      onTap: () {},
    );
  }
}
