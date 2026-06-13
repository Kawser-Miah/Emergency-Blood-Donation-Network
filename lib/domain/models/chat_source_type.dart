enum ChatSourceType {
  bloodRequest,
  donorCard,
  interestResponse,
  direct;

  String toJson() {
    switch (this) {
      case ChatSourceType.bloodRequest:
        return 'blood_request';
      case ChatSourceType.donorCard:
        return 'donor_card';
      case ChatSourceType.interestResponse:
        return 'interest_response';
      case ChatSourceType.direct:
        return 'direct';
    }
  }

  static ChatSourceType fromString(String value) {
    switch (value) {
      case 'blood_request':
        return ChatSourceType.bloodRequest;
      case 'donor_card':
        return ChatSourceType.donorCard;
      case 'interest_response':
        return ChatSourceType.interestResponse;
      default:
        return ChatSourceType.direct;
    }
  }
}
