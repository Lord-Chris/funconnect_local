class PaginatedData<T> {
  final int currentPage;
  final String? firstPageUrl;
  final int from;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final int? prevPageUrl;
  final int to;
  final List<T> data;

  PaginatedData({
    required this.currentPage,
    this.firstPageUrl,
    required this.from,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.data,
  });

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T x) toMap) {
    return {
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'data': data.map(toMap).toList(),
    };
  }

  factory PaginatedData.fromMap(
      Map<String, dynamic> map, T Function(dynamic x) fromMap) {
    return PaginatedData<T>(
      currentPage: map['current_page']?.toInt() ?? 0,
      firstPageUrl: map['first_page_url'],
      from: map['from']?.toInt() ?? 0,
      nextPageUrl: map['next_page_url'],
      path: map['path'] ?? '',
      perPage: map['per_page']?.toInt() ?? 0,
      prevPageUrl: map['prev_page_url']?.toInt(),
      to: map['to']?.toInt() ?? 0,
      data: (map['data'] as List).map(fromMap).toList(),
    );
  }
}
