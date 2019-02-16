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

namespace App.Models {

    public class Bookmark {
        public int bookmarkId {get; set;}
        public string bookmarkName {get; set;}
        public string languages {get; set;}

        public Bookmark (string bookmarkName = "", string languages = "", int bookmarkId = 0) {
            this.bookmarkName = bookmarkName;
            this.languages = languages;
        }
    }

}
