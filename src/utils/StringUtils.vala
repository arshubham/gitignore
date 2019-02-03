/*
* Copyright (C) 2018-2019 Shubham Arora <shubhamarora@protonmail.com>
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

namespace App.Utils {

    public class StringUtils {
        
        public static string[] remove_duplicate_languages (string[] input) {
            string[] output  = {};

            var set = new Gee.HashSet<string> ();

            for (int i = 0 ; i < input.length; i++) {
                set.add (input [i]);
            }
            int i = 0;
            foreach (string s in set) {
                output[i] = s;
                i++;
            }

            return output;
        }
    }
}