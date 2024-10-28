extension AssetName on String {
  String get svg => 'assets/svgs/$this.svg';
  String get png => 'assets/pngs/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get jpeg => 'assets/jpegs/$this.jpeg';
  String get mp4 => 'assets/videos/$this.mp4';
  String get gif => 'assets/gifs/$this.gif';
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool get isNumeric {
    if (isEmpty) {
      return false;
    }
    return double.tryParse(this) != null;
  }
}
