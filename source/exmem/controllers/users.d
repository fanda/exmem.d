module exmem.controllers.users;

import std.stdio;

import vibe.vibe;
import exmem.http_api;
import exmem.models;

class UsersController
{
  this() {
    writeln("C UsersController.");
    auto router = ExmemHttpApi().router();
    router.get("/auth/openid", &openIdAuth);
  }

  void index(HttpServerRequest request, HttpServerResponse response) {
    writeln("A UsersController#openIdAuth().");

    signIn(User.id(), response.startSession());
  }


private:

  void signIn(string user_id, auto session) {
	  session["user_id"] = user_id;
  }


}
