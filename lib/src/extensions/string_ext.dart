extension StringExt on String {
  String getExtensionType() {
    return this.split('.').last;
  }
}
