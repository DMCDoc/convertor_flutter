class MaskConverter {
  String convertMaskToWildcard(String mask) {
    final octets = mask.split('.');
    final wildcard = octets.map((octet) {
      final value = int.parse(octet);
      return (255 - value).toString();
    }).join('.');
    return wildcard;
  }

  bool isValidMask(String mask) {
    const pattern = r'^\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}$';
    final regExp = RegExp(pattern);
    return mask.length <= 15 && regExp.hasMatch(mask);
  }
}
