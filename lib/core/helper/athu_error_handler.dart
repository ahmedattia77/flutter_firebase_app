class AthuErrorHandler {
  static String getLoginErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return errorCode;
      case 'wrong-password':
        return errorCode;
      case 'invalid-email':
        return 'Please enter valid email ';
      case 'user-disabled':
        return 'youre acount has been suspended';
      case 'invalid-credential':
        return 'wrong passwored or email, please try again';
      default:
        return 'fiald to login, try agian ';
    }
  }

  static String getRegisterErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      case 'weak-password':
        return 'Password is too weak, use at least 6 characters';
      case 'user-disabled':
        return 'Your account has been suspended';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Wrong password or email, please try again';
      default:
        return 'Authentication failed, please try again';
    }
  }
}
