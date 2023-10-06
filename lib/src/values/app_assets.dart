class AppAssets {
  static const String path = 'assets/logo/';
  static const String pathImage = 'assets/images/';
  static const String logoBlack = '${path}logo_black.png';
  static const String logoWhite = '${path}logo_white.png';
  static const String logoBlackText = '${path}logo_text_black.png';
  static const String logoWhiteText = '${path}logo_text_white.png';

  static const String googleImage = '${pathImage}googleImage.png';
  static const String foodDeliveryImage = '${path}Logo.png';

  static const String milkteaImage = '${pathImage}milktea.png';
  static const String foodImage = '${pathImage}food.png';
  static const String bundauImage = '${pathImage}imgBundau.png';
  static const String jolibeImage = '${pathImage}jolibeStore.jpg';

  static String getImg(String name, String path) {
    return "assets/$path/$name";
  }
  
}
