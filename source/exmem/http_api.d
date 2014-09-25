module exmem.http_api;

import std.stdio;

import vibe.http.router;
import vibe.http.server;


class ExmemHttpApi
{
private:
    static bool initialized;  // Thread-local

    static HttpServerSettings httpSettings;
    static UrlRouter urlRouter;

    __gshared static ExmemHttpApi api;

    this() {
      writeln("C ExmemHttpApi.");
      httpSettings = new HttpServerSettings;
      urlRouter = new UrlRouter;
      defaults();
      listen();
    }


    void defaults() {
      httpSettings.port = 3000;
      httpSettings.bindAddresses = ["127.0.0.1"];
		  httpSettings.sessionStore = new MemorySessionStore;

      writeln("* Setting http defaults.");
    }

    void listen() {
      listenHttp(httpSettings, urlRouter);
      writeln("* Listening http with url router.");
    }

public:

    static ExmemHttpApi opCall() {
        if (initialized) {
            return api;
        }

        synchronized(ExmemHttpApi.classinfo) {
            scope(success) initialized = true;
            if(api !is null) {
                return api;
            }
            api = new ExmemHttpApi;
            return api;
       }
    }

    UrlRouter* router() {
       return &urlRouter;
    }
    HttpServerSettings* settings() {
      return &httpSettings;
    }

}
