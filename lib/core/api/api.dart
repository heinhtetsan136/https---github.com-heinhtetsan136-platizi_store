abstract class Api {
  Api._();

  static const BaseURl = "https://api.escuelajs.co";
  static const URLV1 = "$BaseURl/api/v1";

//* Auth
  static const String LoginAPI = "/auth/login";
  static const String ProfileAPI = "/auth/profile";
  static const String RefreshAPI = "/auth/refresh";

//* User
  static const String GetAllUsers = "$URLV1/users";

  //*Upload
  static const String Profilephoto = "$URLV1/files/upload";
}
