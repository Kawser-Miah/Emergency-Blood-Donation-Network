import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/application/pages/features/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_bloc.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_event.dart';
import 'package:blood_setu/application/pages/features/chat_list/bloc/conversation_list_state.dart';
import 'package:blood_setu/application/pages/features/chat_list/view/chat_list_screen.dart';
import 'package:blood_setu/application/pages/features/home/view/home_screen.dart';
import 'package:blood_setu/application/pages/features/donors/view/donors_screen.dart';
import 'package:blood_setu/application/pages/features/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = getIt<AuthController>().user?.uid ?? '';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              getIt<BottomNavBloc>()..add(BottomNavEvent.tabChanged(index: 0)),
        ),
        BlocProvider(
          create: (_) => getIt<ConversationListBloc>()
            ..add(ConversationListEvent.watchStarted(uid)),
        ),
      ],
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: _buildPage(state.currentIndex),
            bottomNavigationBar: _BottomNavBar(
              selectedIndex: state.currentIndex,
              onDestinationSelected: (index) {
                context
                    .read<BottomNavBloc>()
                    .add(BottomNavEvent.tabChanged(index: index));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const DonorsScreen();
      case 2:
        return const ChatListScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
      builder: (context, chatState) {
        final unread = chatState.maybeMap(
          loaded: (s) => s.totalUnread,
          orElse: () => 0,
        );
        return BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          currentIndex: selectedIndex,
          onTap: onDestinationSelected,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),
              activeIcon: Icon(Icons.home, size: 26),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.people_outline, size: 26),
              activeIcon: Icon(Icons.people, size: 26),
              label: 'Donors',
            ),
            BottomNavigationBarItem(
              icon: _MessageIcon(
                active: false,
                unread: unread,
              ),
              activeIcon: _MessageIcon(
                active: true,
                unread: unread,
              ),
              label: 'Messages',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              activeIcon: Icon(Icons.person, size: 26),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}

class _MessageIcon extends StatelessWidget {
  const _MessageIcon({required this.active, required this.unread});

  final bool active;
  final int unread;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      active ? Icons.chat_bubble : Icons.chat_bubble_outline,
      size: 26,
    );
    if (unread == 0) return icon;
    return Badge(
      label: Text(
        unread > 99 ? '99+' : '$unread',
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
      ),
      backgroundColor: AppColors.primary,
      child: icon,
    );
  }
}
