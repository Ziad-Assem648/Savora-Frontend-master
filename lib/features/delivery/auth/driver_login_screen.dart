import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savora_app/features/delivery/providers/driver_state.dart';
import 'package:savora_app/features/delivery/services/driver_theme.dart';
import 'package:savora_app/features/delivery/providers/auth_provider.dart';
class DriverLoginScreen extends ConsumerStatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  ConsumerState<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends ConsumerState<DriverLoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 64),
              Text(
                'Savora',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: cs.primary),
              ),
              const SizedBox(height: 8),
              Text(
                'Driver Portal',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 64),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Phone Number',
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '+1 (555) 000-0000',
                          prefixIcon: Icon(Icons.phone_iphone,
                              color: cs.onSurfaceVariant),
                          filled: true,
                          fillColor: DriverTheme.adaptive(context,
                              dark: DriverTheme.background,
                              light: const Color(0xFFF5EEE5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Password',
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢',
                          prefixIcon:
                              Icon(Icons.lock, color: cs.onSurfaceVariant),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: cs.onSurfaceVariant),
                            onPressed: () =>
                                setState(() => _obscureText = !_obscureText),
                          ),
                          filled: true,
                          fillColor: DriverTheme.adaptive(context,
                              dark: DriverTheme.background,
                              light: const Color(0xFFF5EEE5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Forgot Password?',
                              style: TextStyle(color: cs.primary)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(driverAuthProvider.notifier).login();
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.support_agent,
                      color: cs.onSurfaceVariant),
                  label: Text('Contact Support',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
