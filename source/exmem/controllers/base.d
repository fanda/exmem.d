module exmem.controllers.base;

import std.stdio, std.regex;;

import vibe.vibe;
import exmem.http_api;
import exmem.models;


class Controller
{
protected:
  BsonObjectID boardId(HttpServerRequest request) {
    string bid = null;
    if (request.query)
      bid = request.query["bid"];
    //if (null == bid)
    //  bid = request.cookies["bid"];

    if (null == bid) {
      //return BsonObjectID.generate();
      // XXX
      Board board = Board.create( "Exmem.Org" );
      return board._id;
    }

    //writeln("X boardId()==", bid );
    return BsonObjectID.fromString( bid );
  }
}
