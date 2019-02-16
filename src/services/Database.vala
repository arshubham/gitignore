/*
* Copyright (C) 2019 Shubham Arora <shubhamarora@protonmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*
* Authored by: Shubham Arora <shubhamarora@protonmail.com>
*/

namespace App.Services {

    public class Database : GLib.Object {
        private Sqlite.Database db;
        private string db_path;

        public Database (bool skip_tables = false) {
            int rc = 0;

            db_path = Environment.get_home_dir () + "/.local/share/com.github.arshubham.gitignore/database.db";

            if (!skip_tables) {
                if (create_tables () != Sqlite.OK) {
                    stderr.printf ("Error creating db table: %d, %s\n", rc, db.errmsg ());
                    Gtk.main_quit ();
                }
            }

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }
        }

        private int create_tables () {

            int rc;

            rc = Sqlite.Database.open (db_path, out db);

            if (rc != Sqlite.OK) {
                stderr.printf ("Can't open database: %d, %s\n", rc, db.errmsg ());
                Gtk.main_quit ();
            }

            rc = db.exec ("CREATE TABLE IF NOT EXISTS bookmarks (bookmarkId INTEGER PRIMARY KEY AUTOINCREMENT," +
            "bookmarkName VARCHAR," +
            "languages VARCHAR)", null, null);

            debug ("Table library created");

            rc = db.exec ("PRAGMA foreign_keys = ON");

            return rc;
        }

        public void add_bookmark (Models.Bookmark bookmark) {
            Sqlite.Statement stmt;

            int res = db.prepare_v2 ("INSERT INTO bookmarks (bookmarkName, languages)" +
            "VALUES (?, ?)", -1, out stmt);

            assert (res == Sqlite.OK);

            res = stmt.bind_text (1, bookmark.bookmarkName);
            assert (res == Sqlite.OK);

            res = stmt.bind_text (2, bookmark.languages);
            assert (res == Sqlite.OK);

            res = stmt.step ();

            if (res == Sqlite.DONE) {
                debug ("Bookmark Added");
            }  
        }
    }
}
