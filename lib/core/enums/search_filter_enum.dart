enum SearchEnum {
  date('Date'),
  location('Location'),
  interest('Interests');

  const SearchEnum(this.parsed);
  final String parsed;
}
