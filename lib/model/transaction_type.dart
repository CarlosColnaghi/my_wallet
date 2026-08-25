enum TransactionType {
  income('Entrada'), expense('Despesa');

  final String label;

  const TransactionType(this.label);
}