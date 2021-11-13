// Copyright 2021 kaigonzalez
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import std.stdio;
import std.algorithm;
import std.string;
import std.stdint;



struct Img_Tree {
    int state;
    string buff;
    string name;
    string[] args;
}

void error(string text) {
    writeln("error: " ~ text);
}

Img_Tree execute_img_code(string c) {
    Img_Tree mt;
    string point = "";

    string funcname = "";

    int state = 0;

    string[] args;
    for (uint i = 0; i < c.length; ++ i) {
        if (c[i] == '$' && state == 0) {
            state = 1;
        } else if (c[i] == '/' && state == 0) {
            if (c[i++] == '/') break; /* comment */
        } else if (c[i] == ' ' && state == 1) {
            funcname = point;
            point = "";
            state = 2;
        } else if (c[i] == ' ' && state == 2) {
            args = args ~ point;
            point = "";

        } else if (c[i] == '"' && state == 2) {
            state = 122    ;
        } else if (c[i] == '"' && state == 122) {
            state = 2;
        } else {
            point = point ~ c[i];
        }
    }
    if (point.length >0 && state == 2) {
        args = args ~ point;
        point = "";
        state = 0;
    }
    mt.args = args;
    mt.name = funcname;
    return mt;
}
