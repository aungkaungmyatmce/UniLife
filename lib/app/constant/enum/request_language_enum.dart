class LanguageEnums<String> {
  final String languageType;
  final String languageCode;

  const LanguageEnums(this.languageType, this.languageCode);

  static const LanguageEnums ENGLISH = LanguageEnums('English', "en");
  static const LanguageEnums MYANMAR = LanguageEnums("ျမန္မာ", "mm");

}