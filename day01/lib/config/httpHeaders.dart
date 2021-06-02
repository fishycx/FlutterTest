const httpHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'User-Agent': 'ym,iOS,828.0x1792.0, iOS12.0,(V6.0.3)',
  'Authorization': '',
};

Map<String,String> baseParams() {
  return {
    'clientId': 'iOS',
    'appVersion': '6.0.3',
    't': DateTime.now().microsecondsSinceEpoch.toString(),
  };
}
