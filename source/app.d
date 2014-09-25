import vibe.d;

import std.stdio;

import exmem.controllers.base;
import exmem.controllers.boards;
import exmem.controllers.boxes;
import exmem.models;
import exmem.db;

import exmem.http_api;


ExmemHttpApi http_api;

static this()
{
  writeln("* App started.");
	//settings.spamFilters ~= new BlackListSpamFilter;

	/*if( existsFile("settings.json") ){
		auto data = stripUTF8Bom(cast(string)openFile("settings.json").readAll());
		auto json = parseJson(data);
		settings.parseSettings(json);
	}*/

	//settings.sslCert = "server.crt";
	//settings.sslKey = "server.key";

	http_api = ExmemHttpApi();
  writeln("* Factorized singleton ExmemHttpApi.");

  BoardsController boards = new BoardsController;
  BoxesController  boxes  = new BoxesController;

  http_api.router().get("*", serveStaticFiles("public"));

  Controller[] controllers = [
    boards, boxes
  ];


}
