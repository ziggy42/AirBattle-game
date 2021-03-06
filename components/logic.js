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

var matrix
var gameState
var space = 0
var lastIndex
var enemySpeed = 10000//25000
var count = 0// Conta quanta gente ho creato finora

function getCol(x) { return Math.floor(x / gameState.squareSize);}
function getX(col) { return gameState.squareSize*(col+1) - gameState.squareSize;}

function up() {
    var colIndex = Math.floor((Math.random()*10))%gameState.cols

    if(!(lastIndex === colIndex)) {
        var newEnemy = Qt.createQmlObject("import QtQuick 2.0; Enemy2{col:" + colIndex + "}",gameState)
        matrix[colIndex].addEnemy(newEnemy);
    } else {console.log("La colonna " + colIndex + " è occupata")}

    lastIndex = colIndex

    count++
    if(count%7 == 0) {
        enemySpeed = enemySpeed*0.9
        gameState.upInterval = gameState.upInterval*0.9
    }
}

function setTarget(x) {
    var colIndex = getCol(x)

    if(!matrix[colIndex].isEmpty())
        return matrix[colIndex].getY()
    else
        return space
}

function kill(x) {
    var colIndex = getCol(x)
    matrix[colIndex].removeEnemy()
}

function newGame(grid) {
    gameState = grid
    startGame()
    return gameState
}

function startGame() {
    enemySpeed = 10000
    gameState.upInterval = 2000
    gameState.score = 0

    matrix = []
    for(var i = 0; i < gameState.cols; i++)
        matrix.push(new Column(i))
}

function gameOver() {
    gameState.run = false
    for(var i = 0; i < matrix.length; i++) {
        matrix[i].empty();
    }
}
