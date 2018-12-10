/* Generated from Parenscript. */
var DATASTACK = [];
var MAINMEMERY = new Array(510);
var DMA = new Array(510);
var INTERP = false;
var P = 0;
var POINTER = 0;
var OFFSET = 0;
var Q = 0;
var STATE = 0;
function run() {
    return STATE = 3;
};
function runNext() {
    if (STATE === 3) {
        execute(MEMERY[P]);
        return ++P;
    };
};
function spop() {
    return DATASTACK.shift();
};
function dist() {
    return POINTER * 2 + OFFSET;
};
function execute(code) {
    switch (code) {
    case 0:
        idle();
        break;
    case 1:
        load();
        break;
    case 2:
        save();
        break;
    case 3:
        setp();
        break;
    case 4:
        goto();
        break;
    case 5:
        show();
        break;
    case 6:
        brch();
        break;
    case 7:
        offt();
        break;
    case 8:
        offn();
        break;
    case 9:
        dupl();
        break;
    case 10:
        adds();
        break;
    case 11:
        nega();
        break;
    case 12:
        mult();
        break;
    case 13:
        dvid();
        break;
    case 14:
        dmat();
    };
    return undefined;
};
function idle() {
    return STATE = 4;
};
function load() {
    return DATASTACK.unshift(256 * (INTERP ? DMA : MAINMEMERY)[2 * POINTER] + (INTERP ? DMA : MAINMEMERY)[2 * POINTER + 1]);
};
function save() {
    var n = (spop() % 65535 + 65535) % 65535;
    (INTERP ? DMA : MAINMEMERY)[2 * POINTER] = 65280 & n;
    return (INTERP ? DMA : MAINMEMERY)[2 * POINTER + 1] = 255 & n;
};
function setp() {
    ++P;
    return POINTER = (INTERP ? DMA : MAINMEMERY)[P];
};
function goto() {
    return P = dist();
};
function show() {
    return Q = spop();
};
function brch() {
    return 0 === DATASTACK[0] ? goto() : null;
};
function offt() {
    return OFFSET = 1;
};
function offn() {
    return OFFSET = 0;
};
function dupl() {
    return DATASTACK.unshift(DATASTACK[0]);
};
function adds() {
    return DATASTACK[0] = spop() + DATASTACK[0];
};
function nega() {
    return DATASTACK[0] = spop() - DATASTACK[0];
};
function mult() {
    return DATASTACK[0] = spop() * DATASTACK[0];
};
function divd() {
    return DATASTACK[0] = Math.floor(spop() / DATASTACK[0]);
};
function dmat() {
    return INTERP ? (INTERP = false) : (INTERP = true);
};
