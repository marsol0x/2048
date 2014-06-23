package;

import haxe.ds.Vector;
import Math;

class Board {
    public var width(default, null):Int;
    public var height(default, null):Int;
    private var board:Vector<Int>;

    public function new(w:Int, h:Int) {
        width = w;
        height = h;
        board = new Vector<Int>(width * height);
    }

    public function get(x:Int, y:Int):Int {
        return board[x * width + y];
    }

    private function set(x:Int, y:Int, val:Int) {
        board[x * width + y] = val;
    }

    public function setRandom(num:Int) {
        while (true) {
            var index = Math.floor(Math.random() * width * height - 1);
            if (board[index] == 0) {
                board[index] = num;
                break;
            }
        }
    }

    public function hasFours():Bool {
        for (i in 0...board.length) {
            if (board[i] >= 4) {
                return true;
            }
        }
        return false;
    }

    public function shiftLeft() {
        for (i in 0...height) {
            var list = new Vector<Int>(width);
            for (x in 0...width) {
                list[x] = get(x, i);
            }
            list = shift(list);
            for (x in 0...width) {
                set(x, i, list[x]);
            }
        }
    }

    public function shiftUp() {
        for (i in 0...width) {
            var list = new Vector<Int>(height);
            for (y in 0...height) {
                list[y] = get(i, y);
            }
            list = shift(list);
            for (y in 0...height) {
                set(i, y, list[y]);
            }
        }
    }

    public function shiftRight() {
        for (i in 0...height) {
            var list = new Vector<Int>(width);
            for (x in 0...width) {
                list[x] = get(x, i);
            }
            list = shift(reverseVector(list));
            list = reverseVector(list);
            for (x in 0...width) {
                set(x, i, list[x]);
            }
        }
    }

    public function shiftDown() {
        for (i in 0...width) {
            var list = new Vector<Int>(height);
            for (y in 0...height) {
                list[y] = get(i, y);
            }
            list = shift(reverseVector(list));
            list = reverseVector(list);
            for (y in 0...height) {
                set(i, y, list[y]);
            }
        }
    }

    private function shift(list:Vector<Int>):Vector<Int> {
        for (x in 0...list.length) { // This needs to happen for length number of times
            for (i in 0...list.length) {
                var cur = list[i];
                var next = if (i == list.length - 1) 0 else list[i + 1];

                if (cur == next) {
                    cur = cur + next;
                    next = 0;
                } else if (cur == 0) {
                    cur = next;
                    next = 0;
                }

                list[i] = cur;
                if (i != list.length - 1) {
                    list[i + 1] = next;
                }
            }
        }
        return list;
    }

    private function reverseVector(list:Vector<Int>):Vector<Int> {
        var v = new Vector<Int>(list.length);
        for (i in 0...list.length) {
            v[list.length - (i + 1)] = list[i];
        }
        return v;
    }

    public function get_width() { return width; }
    public function get_height() { return height; }
}
