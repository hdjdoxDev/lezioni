enum OrarioLezioni {
  primo,
  secondo,
  terzo,
  quarto;

  @override
  String toString() {
    switch (this) {
      case primo:
        return '09 - 11';
      case secondo:
        return '11 - 13';
      case terzo:
        return '14 - 16';
      case quarto:
        return '16 - 18';
    }
  }
}
