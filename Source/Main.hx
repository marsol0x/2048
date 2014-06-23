package;

import Math;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;

class Main extends Sprite {
    private var board:Board;

    public function new () {
        super ();

        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyHandler);

        newGame();
    }

    private function newGame() {
        board = new Board(4, 4);

        // Ask the board to place a random 2
        board.setRandom(2);

        // Start game
        tick();
    }

    private function tick() {
        if (board.hasFours()) {
            if (Math.random() >= 0.75) {
                board.setRandom(4);
            } else {
                board.setRandom(2);
            }
        } else {
            board.setRandom(2);
        }

        render();
    }

    private function render() {
        graphics.clear();
        removeChildren();
        for (x in 0...board.width) {
            for (y in 0...board.height) {
                var tile:Bitmap;
                switch board.get(x, y) {
                    case 2: tile = new Bitmap(new Tiles.Tile2());
                    case 4: tile = new Bitmap(new Tiles.Tile4());
                    case 8: tile = new Bitmap(new Tiles.Tile8());
                    case 16: tile = new Bitmap(new Tiles.Tile16());
                    case 32: tile = new Bitmap(new Tiles.Tile32());
                    case 64: tile = new Bitmap(new Tiles.Tile64());
                    case 128: tile = new Bitmap(new Tiles.Tile128());
                    case 256: tile = new Bitmap(new Tiles.Tile256());
                    case 512: tile = new Bitmap(new Tiles.Tile512());
                    case 1024: tile = new Bitmap(new Tiles.Tile1024());
                    case 2048: tile = new Bitmap(new Tiles.Tile2048());
                    default: tile = new Bitmap(new Tiles.TileBG());
                }
                addChild(tile);
                tile.x = (x * 100) + 5;
                tile.y = (y * 100) + 5;
            }
        }
    }

    public function keyHandler(event:KeyboardEvent) {
        switch event.keyCode {
            case 37: // Left
                board.shiftLeft();
            case 38: // Up
                board.shiftUp();
            case 39: // Right
                board.shiftRight();
            case 40: // Down
                board.shiftDown();
            default:
                return;
        }
        tick();
    }
}
