enum PAGES {
  splash,
  signin,
  register,
  home,
  donors,
  bloodRequests,
  chats,
  chat,
  createRequest,
  profile,
  editProfile,
  mapPicker,
  myRequests,
  myInterests,
  donationHistory,
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
      case PAGES.bloodRequests:
        return '/bloodRequests';
      case PAGES.chats:
        return '/chats';
      case PAGES.chat:
        return '/chat';
      case PAGES.createRequest:
        return '/createRequest';
      case PAGES.profile:
        return '/profile';
      case PAGES.editProfile:
        return '/editProfile';
      case PAGES.mapPicker:
        return '/mapPicker';
      case PAGES.myRequests:
        return '/myRequests';
      case PAGES.myInterests:
        return '/myInterests';
      case PAGES.donationHistory:
        return '/donationHistory';
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
      case PAGES.bloodRequests:
        return 'Blood Requests';
      case PAGES.chats:
        return 'Chats';
      case PAGES.chat:
        return 'Chat';
      case PAGES.createRequest:
        return 'Create Request';
      case PAGES.profile:
        return 'Profile';
      case PAGES.editProfile:
        return 'Edit Profile';
      case PAGES.mapPicker:
        return 'Map Picker';
      case PAGES.myRequests:
        return 'My Requests';
      case PAGES.myInterests:
        return 'My Interests';
      case PAGES.donationHistory:
        return 'Donation History';
    }
  }
}
