/* Generated from Parenscript. */
var CHARARRAY = ['A', 'B', 'C', 'D', 'E', 'F'];
function toHex(n) {
    return n < 10 ? String(n) : CHARARRAY[n - 10];
};
function makeHex() {
    return toHex((240 & hexDisp) / 16) + toHex(15 & hexDisp);
};
function makeByte() {
    return (function () {
        var sum1 = 0;
        for (var i = 0; i <= 7; i += 1) {
            sum1 += Math.pow(2, 7 - i) * switches[i];
        };
        return sum1;
    })();
};
function state() {
    return 'State: ' + (function () {
        switch (STATE) {
        case 0:
            return 'rest';
        case 1:
            return 'load';
        case 3:
            return 'run';
        case 4:
            return ' idle';
        };
    })();
};
function output(s) {
    return hexDisp = s;
};
function drawSwitch() {
    for (var i = 0; i <= 7; i += 1) {
        if (switches[i] === 1) {
            fill(100, 100, 100);
        } else {
            fill(100, 100, 25);
        };
        ellipse(135 + 30 * i, 140, 15, 15);
    };
};
function keyPressed() {
    if (keyCode === 73) {
        if (STATE === 1) {
            nInput(makeByte());
            output(makeByte());
        };
    } else if (keyCode < 57 && keyCode > 48) {
        switches[keyCode - 49] = 0 === switches[keyCode - 49] ? 1 : 0;
    } else if (keyCode === 76) {
        P = 0;
        STATE = 1;
    } else if (keyCode === 82) {
        P = 0;
        STATE = 3;
    } else if (keyCode === 83) {
        P = 0;
        STATE = 0;
    } else if (keyCode === 67) {
        cleanMem();
        DATASTACK = [];
        POINTER = 0;
        P = 0;
        STATE = 0;
        Q = 0;
        hexDisp = 0;
    };
    return undefined;
};
var hexDisp = 0;
var switches = [0, 0, 0, 0, 0, 0, 0, 0];
function setup() {
    createCanvas(400, 400);
    cleanMem();
    return undefined;
};
function draw() {
    colorMode(HSB, 100);
    noStroke();
    fill(19, 34, 85);
    rect(2, 2, width - 4, width - 4, 20, 20, 5, 5);
    textSize(32);
    fill(0);
    text('Nero\'s Computer', 20, 50);
    text(makeHex(hexDisp), 200, 300);
    text(String(Q), 200, 350);
    text(state(), 200, 200);
    if (STATE === 3) {
        runNext();
    };
    drawSwitch();
    return undefined;
};