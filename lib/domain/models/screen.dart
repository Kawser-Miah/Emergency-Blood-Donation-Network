enum AppScreen {
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

extension AppScreenX on AppScreen {
  String get slug {
    switch (this) {
      case AppScreen.splash:
        return 'splash';
      case AppScreen.signin:
        return 'signin';
      case AppScreen.register:
        return 'register';
      case AppScreen.home:
        return 'home';
      case AppScreen.donors:
        return 'donors';
      case AppScreen.chats:
        return 'chats';
      case AppScreen.chat:
        return 'chat';
      case AppScreen.createRequest:
        return 'create-request';
      case AppScreen.profile:
        return 'profile';
    }
  }

  static AppScreen? fromSlug(String s) {
    switch (s) {
      case 'splash':
        return AppScreen.splash;
      case 'signin':
        return AppScreen.signin;
      case 'register':
        return AppScreen.register;
      case 'home':
        return AppScreen.home;
      case 'donors':
        return AppScreen.donors;
      case 'chats':
        return AppScreen.chats;
      case 'chat':
        return AppScreen.chat;
      case 'create-request':
        return AppScreen.createRequest;
      case 'profile':
        return AppScreen.profile;
    }
    return null;
  }
}
