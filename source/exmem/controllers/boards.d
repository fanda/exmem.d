module exmem.controllers.boards;

import std.stdio, std.regex;;

import vibe.vibe;
import exmem.http_api;
import exmem.models;
import exmem.controllers.base;


class BoardsController : Controller
{
  this() {
    writeln("C BoardsController.");
    auto router = ExmemHttpApi().router();
    router.get("/", &show);
    router.get("/board.json", &getBoardJson);
    router.post("/board/create", &create);
    router.post("/board/delete", &destroy);
    router.post("/board/save_columns", &saveColumns);
  }

  void destroy(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#destroy().");

    scope(success)
      response.writeBody("1", "text/plain");
	  scope(failure)
      response.writeBody("0", "text/plain");

    Board.destroy(boardId(request), User.id());
  }

  void getBoardJson(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#getBoardJson().");

    string[][] columns;
    Json board;

    scope(success)
      response.setCookie("bid", board._id.toString(), "/");
    scope(exit)
      response.writeJsonBody!(Json)(board);

    board = Board.getJson(boardId(request), User.id());
    deserializeJson!(string[][])(columns, board.columns);
  }


  void show(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#show().");
    writeln("| ", request.queryString, "\t", User.id() );

    string[][] columns;
    Json board;

    scope(success)
      response.setCookie("bid", board._id.toString(), "/");
    scope(exit)
      response.renderCompat!("exmem.view.show_board.dt",
            Json, "boxes",  string[][], "columns"
        )(board["boxes"], columns);

    board = Board.getJson(boardId(request), User.id());
    deserializeJson!(string[][])(columns, board.columns);
  }

  void create(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#create().");
    writeln(request.queryString);
    writeln(request.json);

    Board board;

    scope(success)
      response.setCookie("bid", board._id.toString(), "");
    scope(exit)
      response.writeJsonBody!(Board)(board);

    board = Board.create(request.query["name"]);
  }

  void saveColumns(HttpServerRequest request, HttpServerResponse response) {
    writeln("A BoardsController#saveColumns().");

    // Validate data

    Board board;

    scope(success)
      response.writeBody("1", "text/plain");
	  scope(failure)
      response.writeBody("0", "text/plain");

    board = Board.get(boardId(request), User.id());
    board.set("columns", Bson.fromJson(request.json));
  }

}
