class HistoryModel {
  final int idOrder, idUserCreate;
  final String content;
  final bool isCreate;
  final DateTime dateUpdate;

  HistoryModel(
      {this.idOrder,
      this.idUserCreate,
      this.content,
      this.isCreate,
      this.dateUpdate});
}
