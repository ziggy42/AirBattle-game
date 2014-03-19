.pragma library

function Column(index) {
    this.index = index
    this.container = []

    this.addEnemy = function(enemy) { this.container.push(enemy)}

    this.removeEnemy = function() {
        try{
            if(this.container[0].die())
                this.container.shift()
        }
        catch(err){
            // se non c'è nessuno da uccidere mi parte l'eccezione
            console.log("Exeption detected")
        }
    }

    this.getY = function() { return this.container[0].y}
    this.isEmpty = function() { return (this.container.length === undefined || this.container.length === 0) ? true: false }

    this.empty = function () {
        for(var i = 0; i < this.container.length; i++) {
            this.container[i].destroy()
        }
    }

    this.pauseOrResume = function() {
        for(var i = 0; i < this.container.length; i++)
            this.container[i].run = !this.container[i].run
    }
}

var column0 = new Column(0)
var column1 = new Column(1)
var column2 = new Column(2)
var column3 = new Column(3)
var column4 = new Column(4)
var column5 = new Column(5)

var column6 = new Column(6)
var column7 = new Column(7)


var matrix = [column0, column1, column2, column3, column4, column5, column6, column7 ]
var gameState
var space = 0
var lastIndex
var enemySpeed = 25000

function getCol(x) { return Math.floor(x / gameState.squareSize);}
function getX(col) { return gameState.squareSize*(col+1) - gameState.squareSize;}

function up() {
    var colIndex = Math.floor((Math.random()*10))%gameState.cols

    if(!(lastIndex === colIndex)) {
        var newEnemy = Qt.createQmlObject("import QtQuick 2.0; Enemy2{col:" + colIndex + "}",gameState)
        matrix[colIndex].addEnemy(newEnemy);
    } else {console.log("La colonna " + colIndex + " è occupata")}

    lastIndex = colIndex
}

function setTarget(x) {
    var colIndex = getCol(x)

    if(!matrix[colIndex].isEmpty()) {
        return matrix[colIndex].getY()
    }
    else {
        return space
    }
}

function kill(x) {
    var colIndex = getCol(x)
    matrix[colIndex].removeEnemy()
}

function newGame(grid) { // inizializza un nuovo gioco
    gameState = grid
    gameState.restore()

    startGame()

    return gameState
}

function injuried(){ gameState.lives --; }

function pR() {
    for(var i = 0; i < matrix.length; i++)
        matrix[i].pauseOrResume()

    gameState.upRunning = !gameState.upRunning
}

function audio() {
    gameState.cannonSound = !gameState.cannonSound
    gameState.explosionSound = !gameState.explosionSound
}

function startGame() {
    gameState.restore()

    for(var i = 0; i < matrix.length; i++){
        matrix[i].empty()
    }

    column0 = new Column(0)
    column1 = new Column(1)
    column2 = new Column(2)
    column3 = new Column(3)
    column4 = new Column(4)
    column5 = new Column(5)
    column6 = new Column(6)
    column7 = new Column(7)
    matrix = [column0, column1, column2, column3, column4, column5, column6, column7 ]
}

function gameOver() {
    gameState.upRunning = false
    for(var i = 0; i < matrix.length; i++) {
        matrix[i].empty();
    }
}

/*

function levelUp() {
    gameState.upInterval = gameState.upInterval*0.9
    enemySpeed -= 5000
}
  */
