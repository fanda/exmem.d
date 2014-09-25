module exmem.auth;

import std.stdio;

import vibe.http.router;
import vibe.http.server;

class ExmemAuth
{

  this() {
    writeln("AUTH #this.");
    auto router = ExmemHttpApi().router();
    router.get("/session/new", &show);
    router.post("/session/create", &create);
  }


  void show(HttpServerRequest request, HttpServerResponse response) {
    writeln("AUTH #show().");
    scope(success)
      response.setCookie("bid", board._id.toString(), "/");
    scope(exit)
      response.renderCompat!("exmem.view.login.dt", Json, "user" )( user );

    board = Board.getJson(boardId(request), User.id());
    deserializeJson!(string[][])(columns, board.columns);
  }

  void create(HttpServerRequest request, HttpServerResponse response) {
    writeln("AUTH #create().");


    scope(success)
      // redirect to / with bid in cookie
    scope(exit)
      //response.writeJsonBody!(Board)(board);

    user = User.find(request.query["user"]);
  }


}
