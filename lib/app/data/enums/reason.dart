  // ignore: constant_identifier_names
  enum Reason { BROWSING, FRIENDS, LOVE }

  String getReasonString(Reason reason) {
    switch (reason) {
      case Reason.FRIENDS:
        return 'FRIENDS';
      case Reason.BROWSING:
        return 'BROWSING';
      case Reason.LOVE:
        return 'LOVE';
      default:
        return 'LOVE';
    }
  }

  Reason getReason(String reason) {
    switch (reason) {
      case 'FRIENDS':
        return Reason.FRIENDS;
      case 'BROWSING':
        return Reason.BROWSING;
      case 'LOVE':
        return Reason.LOVE;
      default:
        return Reason.FRIENDS;
    }
  }
