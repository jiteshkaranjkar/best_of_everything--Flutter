class PollItem {
  String id;
  String name;
  int inc;
  int dec;
  PollItem(this.id, this.name, this.inc, this.dec);
}

class Polls {
  String documentId;
  String title;
  List<PollItem> lstPollItems;
  Polls(this.title, this.documentId, this.lstPollItems);
}
