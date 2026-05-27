import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  void _showEditProfileDialog(BuildContext context, ProfileViewModel vm) {
    final profile = vm.userProfile.value;
    if (profile == null) return;

    final nameController = TextEditingController(text: profile.name);
    final phoneController = TextEditingController(text: profile.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              vm.updateProfile(
                name: nameController.text.trim(),
                phone: phoneController.text.trim(),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context, ProfileViewModel vm) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, vm);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, vm);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, ProfileViewModel vm) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        await vm.uploadProfilePicture(pickedFile);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vm = Get.find<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => _showEditProfileDialog(context, vm),
            icon: const Icon(Icons.edit_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }



        final profile = vm.userProfile.value;

        final contactDetails = [
          _ProfileDetail(label: 'Email', value: profile.email, icon: Icons.mail_outline),
          _ProfileDetail(label: 'Phone', value: profile.phone.isNotEmpty ? profile.phone : 'Not set', icon: Icons.phone_outlined),
          const _ProfileDetail(label: 'Primary provider', value: 'Dr. Abdullah', icon: Icons.medical_services_outlined),
          const _ProfileDetail(label: 'Care partner since', value: 'January 2022', icon: Icons.calendar_today_outlined),
        ];

        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            GlassCard(
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: .1),
                        backgroundImage: (profile.photoUrl?.isNotEmpty ?? false)
                            ? NetworkImage(profile.photoUrl!)
                            : null,
                        child: (profile.photoUrl?.isEmpty ?? true)
                            ? Icon(Icons.person, size: 36, color: theme.colorScheme.primary)
                            : null,
                      ),
                      Obx(() {
                        if (vm.isUploading.value) {
                          return Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Obx(() => GestureDetector(
                          onTap: vm.isUploading.value
                              ? null
                              : () => _showImageSourceDialog(context, vm),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.name, style: theme.textTheme.headlineSmall),
                        const SizedBox(height: 4),
                        Text('${profile.role} · Family', style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: const [
                            Chip(label: Text('Medication lead')),
                            Chip(label: Text('Emergency contact')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SectionHeader(title: 'Care overview', actionLabel: 'View plan', onActionTap: () {}),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: _StatCard(
                    label: 'Care tasks',
                    value: '12 active',
                    detail: '3 due today',
                    icon: Icons.check_circle_outline,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    label: 'Support hours',
                    value: '18 hrs',
                    detail: 'This week',
                    icon: Icons.timer_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            SectionHeader(title: 'Contact info'),
            const SizedBox(height: 12),
            ...contactDetails.map(
              (detail) => Card(
                child: ListTile(
                  leading: Icon(detail.icon),
                  title: Text(detail.label),
                  subtitle: Text(detail.value),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Care circle'),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.secondary.withValues(alpha: .15),
                  child: Icon(Icons.group_outlined, color: theme.colorScheme.secondary),
                ),
                title: const Text('Invite a caregiver'),
                subtitle: const Text('Share access and coordinate together'),
                trailing: const Icon(Icons.add),
                onTap: () {},
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.detail, required this.icon});

  final String label;
  final String value;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 2),
          Text(detail, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _ProfileDetail {
  const _ProfileDetail({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;
}

