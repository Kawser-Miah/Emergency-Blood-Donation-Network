enum PAGES {
  splash,
  signin,
  register,
  home,
  donors,
  chats,
  chat,
  createRequest,
  profile,
}

extension AppPageExtention on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.splash:
        return '/';
      case PAGES.signin:
        return '/signin';
      case PAGES.register:
        return '/register';
      case PAGES.home:
        return '/home';
      case PAGES.donors:
        return '/donors';
      case PAGES.chats:
        return '/chats';
      case PAGES.chat:
        return '/chat';
      case PAGES.createRequest:
        return '/createRequest';
      case PAGES.profile:
        return '/profile';
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.splash:
        return 'Splash';
      case PAGES.signin:
        return 'Sign In';
      case PAGES.register:
        return 'Register';
      case PAGES.home:
        return 'Home';
      case PAGES.donors:
        return 'Donors';
      case PAGES.chats:
        return 'Chats';
      case PAGES.chat:
        return 'Chat';
      case PAGES.createRequest:
        return 'Create Request';
      case PAGES.profile:
        return 'Profile';
    }
  }
}
