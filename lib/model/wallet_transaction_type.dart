enum WalletTransactionType {
  income('Entrada'), expense('Despesa');

  final String label;

  const WalletTransactionType(this.label);

  static WalletTransactionType fromString(String value) => values.firstWhere((type) => type.label.toLowerCase == value.toLowerCase);

}