module exmem.db; // deebee-dot-dee is singleton, hm

import std.stdio;

import vibe.db.mongo.mongo;
import vibe.db.mongo.database;

class Db
{
private:
    static bool initialized;  // Thread-local
    __gshared static Db db;

    static MongoDatabase mongo;

    this() {
      writeln("C Db.");
      mongo = connectMongoDB("127.0.0.1").getDatabase("exmem");
      writeln("* Created MongoDB connection.");
    }

public:

    static Db opCall() {
        if (initialized) {
            return db;
        }

        synchronized(Db.classinfo) {
            scope(success) initialized = true;
            if(db !is null) {
                return db;
            }
            db = new Db;
            return db;
       }
    }

    auto get(string collection) {
      writeln("* MongoDB.", collection, " access.");
      return mongo[collection];
    }


}
