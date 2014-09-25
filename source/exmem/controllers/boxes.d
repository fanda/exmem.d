module exmem.controllers.boxes;

import std.stdio, std.regex;;

import vibe.vibe;
import exmem.http_api;
import exmem.models;
import exmem.controllers.base;


class BoxesController : Controller
{
  this() {
    writeln("C BoxesController.");
    auto router = ExmemHttpApi().router();
    router.any("/board/:box/new", &insertRecord);
    router.any("/board/:box/:query", &updateRecord);
  }

  void insertRecord(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#insertRecord().");

    writeln("| ", request.params["box"] );
    writeln("| ", request.queryString );
    writeln("| ", request.json );

    scope(success)
      response.writeBody("1", "text/plain");
	  scope(failure)
      response.writeBody("0", "text/plain");

    Board.newBoxRecord(boardId(request), User.id(), request.params["box"], Bson.fromJson(request.json));
  }

  void updateRecord(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#updateRecord().");

    string query = request.params["query"]; // todo sub/_/./
    query = request.params["box"] ~ "." ~ query;

    writeln("| ", query );

    Json board = Board.getJson(boardId(request), User.id());

    scope(success)
      response.writeBody("1", "text/plain");
	  scope(failure)
      response.writeBody("0", "text/plain");

    board.boxes[request.params["box"]];
    board.set("boxes." ~ query, Bson.fromJson(request.json));
  }


}
