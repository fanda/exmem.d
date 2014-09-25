
module exmem.models;
import exmem.db;

import vibe.data.bson;
import vibe.data.json;

import std.stdio;

struct User
{
  BsonObjectID  _id;
  string        name;
  string        email;

  static BsonObjectID id() {
    return BsonObjectID.fromString("51597725447cba551535ea58");//BsonObjectID.generate();
    // localhot return BsonObjectID.fromString("511e0fbff0a1392c14021b02");//BsonObjectID.generate();
  }

}

struct Board
{
  BsonObjectID  _id;
  BsonObjectID  user_id;
  string        name;
  string        background;

  string[][]     columns;

  Box[string] boxes;


  void neverDestroyMainBoard() {
    /*
    if self == user.boards.first or self.id == 1
      return false
    end
    true
    */
  }

  static Board[] all() {
    auto doc = Db().get("boards").find();
    Board[] boards;
    int i = 0;
    foreach ( board; doc) {
      auto b = deserializeBson!(Board)(board);
      boards[i++] = b;
    }
    // = deserializeBson!(Board)(doc);
    return boards;
  }

  static Json getJson(BsonObjectID _id, BsonObjectID user_id) {
    auto doc = Db().get("boards").findOne(["_id": _id, "user_id": user_id]);
    return doc.toJson();
  }

  static Board get(BsonObjectID _id, BsonObjectID user_id) {
    writeln("D ", "Board.get()");
    auto doc = Db().get("boards").findOne(
      ["_id": _id, "user_id": user_id]/*,
      ["background": 1, "boxes": 1, "columns": 1, "name": 1]*/
    );
    writeln("D ", "blak");
    // XXX enforce( !doc.isNull(), "Board not found");
    Board b = deserializeBson!(Board)(doc);
    return b;
  }

  static Board create(string name) {
    Board board;
    board._id = BsonObjectID.generate();
    board.name = name;
    board.background = "default";
    board.user_id = User.id();
//    board.prefColumns =

    /*board.boxes << new LinksBox;
    board.boxes << new PhoneNumbersBox;
    board.boxes << new ThoughtsBox;
    board.boxes << new RssBox;*/

    Db().get("boards").insert(board);

    return board;
  }

  static void destroy(BsonObjectID _id, BsonObjectID user_id) {
    auto doc = Db().get("boards").findOne(["_id": _id, "user_id": user_id]);
    //enforce( !doc.isNull(), "Board not found");
    Db().get("boards").remove(["_id":_id, "user_id": user_id]);
  }

  void set(string query, Bson newValue) {
    Db().get("boards").update(["_id": _id, "user_id": user_id], ["$set": [query: newValue]]);
    writeln("D ", query);
  }

  static void newBoxRecord(BsonObjectID _id, BsonObjectID user_id, string box, Bson record) {
    string query = "boxes."~box~".content";

    Db().get("boards").update(["_id": _id, "user_id": user_id], ["$push": [query: record]]);
    writeln("D ", query);


  }



}

class Box
{
  string title;
  string colour;
  string model;
  Json content;
}


