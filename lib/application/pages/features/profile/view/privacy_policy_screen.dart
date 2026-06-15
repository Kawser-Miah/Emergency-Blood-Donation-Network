import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _PolicyHeader(),
          SizedBox(height: 20),
          _PolicySection(
            title: '1. Information We Collect',
            icon: Icons.info_outline,
            content:
                'We collect the following personal information when you register and use Blood Setu:\n\n'
                '• Full name, gender, and age\n'
                '• Blood group\n'
                '• Phone number and Facebook Messenger ID\n'
                '• District and Thana/Upazila location\n'
                '• Donation history and last donation date\n'
                '• Device location (only when you enable nearby donor search)',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '2. How We Use Your Information',
            icon: Icons.security_outlined,
            content:
                'Your information is used solely for the purpose of saving lives through blood donation:\n\n'
                '• Matching blood seekers with compatible nearby donors\n'
                '• Displaying your profile to people who need your blood group\n'
                '• Sending you notifications about urgent requests nearby\n'
                '• Tracking donation history to determine your next eligible date\n'
                '• Improving the accuracy and reliability of our matching system',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '3. Location Data',
            icon: Icons.location_on_outlined,
            content:
                'Blood Setu uses your location to find donors and recipients near you:\n\n'
                '• Location is only accessed when you actively use the nearby donor or request features\n'
                '• We store your approximate location (district and thana) for matching purposes\n'
                '• Precise GPS coordinates are only used in-session and are not stored permanently\n'
                '• You can disable location access at any time from your device settings',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '4. Data Sharing',
            icon: Icons.share_outlined,
            content:
                'We do not sell, trade, or rent your personal information to third parties.\n\n'
                '• Your name, blood group, and district are visible to other users when you are set as Active\n'
                '• Your phone number is only shared when you explicitly respond to a blood request\n'
                '• We may share anonymised, aggregated data for public health research\n'
                '• We may disclose information if required by law or to protect safety',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '5. Data Security',
            icon: Icons.lock_outline,
            content:
                'We take reasonable measures to protect your information:\n\n'
                '• All data is stored securely on Firebase (Google Cloud) with encryption at rest\n'
                '• Authentication is handled via Firebase Authentication\n'
                '• We use HTTPS for all data transmission\n'
                '• Access to your data is restricted to authorised personnel only\n'
                '• We recommend keeping your app updated to receive the latest security fixes',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '6. Your Rights',
            icon: Icons.person_outline,
            content:
                'You have full control over your personal data:\n\n'
                '• Edit Profile — update your information at any time\n'
                '• Active / Inactive toggle — hide your profile from searches instantly\n'
                '• Account deletion — contact us to permanently delete all your data\n'
                '• Data export — request a copy of your personal data at any time\n'
                '• Consent withdrawal — you may withdraw consent by deleting your account',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '7. Children\'s Privacy',
            icon: Icons.child_care_outlined,
            content:
                'Blood Setu is intended for users aged 18 and above (or 16 with parental consent in some regions).\n\n'
                'We do not knowingly collect personal information from children under 16. '
                'If we discover that a child under 16 has provided us with personal information, '
                'we will delete it immediately. If you believe a child has registered, '
                'please contact us at the address below.',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '8. Changes to This Policy',
            icon: Icons.update_outlined,
            content:
                'We may update this Privacy Policy from time to time to reflect changes in our practices or for legal reasons.\n\n'
                'When we make significant changes, we will notify you through the app or via your registered contact. '
                'Your continued use of Blood Setu after changes are posted constitutes acceptance of the updated policy.\n\n'
                'Last updated: June 2025',
          ),
          SizedBox(height: 16),
          _PolicySection(
            title: '9. Contact Us',
            icon: Icons.mail_outline,
            content:
                'If you have any questions, concerns, or requests regarding your privacy, please reach out to us:\n\n'
                '📧  support@bloodsetu.app\n'
                '🌐  www.bloodsetu.app/privacy\n'
                '📍  Dhaka, Bangladesh\n\n'
                'We aim to respond to all privacy-related inquiries within 5 business days.',
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _PolicyHeader extends StatelessWidget {
  const _PolicyHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.privacy_tip_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Your Privacy Matters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Blood Setu is built on trust. We are committed to protecting your personal information '
            'and being transparent about how we use it to connect donors with people in need.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.88),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.textMuted,
          childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            const Divider(height: 1, color: AppColors.dividerLightest),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
