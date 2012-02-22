/* This script file handles the game logic */
var maxColumn = 9;
var maxRow = 9;
var maxIndex = maxColumn*maxRow;
var board = new Array(maxIndex);
var blockSrc = "core/BallBlock.qml";
var scoresURL = "";
var gameDuration;
var component = Qt.createComponent(blockSrc);
var ballScore = 2;

var INIT_BALL = 0;
var SELECT_BALL = 1;
var ALIVE_BALL =2 ;
var DEATH_BALL = 3;
var n_BALL_TYPE = 5;

var HORIZONTAL = 0;
var VERTICAL = 1;
var LEFT_DIAGONAL = 2;
var RIGHT_DIAGONAL = 3;
function getColumn(index){
    return Math.floor(index%maxColumn);
}
function getRow(index){
    return  Math.floor(index/maxRow);
}

//Index function used instead of a 2D array
function index(column,row) {
    return column + (row * maxColumn);
}

function timeStr(msecs) {
    var secs = Math.floor(msecs/1000);
    var m = Math.floor(secs/60);
    var ret = "" + m + "m " + (secs%60) + "s";
    return ret;
}

function startNewGame()
{
    var i;
    for(i = 0; i<maxIndex; i++){
        if(board[i] != null)
            board[i].destroy();
        board[i] = null;
    }
    for (i = 0; i<3; i++){
        createRandomBall(INIT_BALL);
        createRandomBall(ALIVE_BALL);
    }

    //Close dialogs
    //    nameInputDialog.forceClose();
    //    dialog.forceClose();

    //Initialize Board
    //    board = new Array(maxIndex);
    gameGrid.score = 0;

    //    gameDuration = new Date();
}


var selectedIndex = -1;
var lackBall = false;
function handleClick(x,y)
{
    var column = Math.floor(x/gameGrid.blockSize);
    var row = Math.floor(y/gameGrid.blockSize);
    var currentIndex = index(column,row);
    var currentBall = board[currentIndex];

    if(selectedIndex == -1){
        if(currentBall == null)
            return;
        switch(currentBall.ballState){

        case ALIVE_BALL:
            selectedIndex =currentIndex;
            currentBall.ballState = SELECT_BALL;
            break;
        case INIT_BALL:
        case SELECT_BALL:
        default:
            return;
        }
    }else{
        if(currentBall == null) {
            if (existPath(selectedIndex,currentIndex)){
                displayPath();
                createSingleBall(currentIndex, board[selectedIndex].type, ALIVE_BALL);
                board[selectedIndex].destroy();
                board[selectedIndex] = null;
                if(isDestructible(currentIndex, false)){
                    destroyBall();
                    console.debug("call from currentball == null");
                    calculateScore();
                }else{
                    selectedIndex = -1;
                    endGameCheck();
                    nextTurn();
                }
                selectedIndex = -1;
            }
            return;
        }else{
            switch(currentBall.ballState){
            case INIT_BALL:
                if (existPath(selectedIndex,currentIndex)){
                    displayPath();
                    createSingleBall(currentIndex, board[selectedIndex].type, ALIVE_BALL);
                    board[selectedIndex].destroy();
                    board[selectedIndex] = null;
                    if(isDestructible(currentIndex, false)){
                        destroyBall();
                        console.debug("call from currentball.ballState");
                        calculateScore();
                        board[currentIndex] = currentBall;
                    }else{
                        lackBall = true;
                        currentBall.destroy();
                        endGameCheck();
                        nextTurn();
                    }
                    selectedIndex = -1;
                }
                break;
            case ALIVE_BALL:
                board[selectedIndex].ballState = ALIVE_BALL;
                currentBall.ballState = SELECT_BALL;
                selectedIndex = currentIndex;
                break;
            case SELECT_BALL:
            default:
                return;
            }
        }
    }
}

var destroyBalls = new Array(maxColumn);
var destroyBallLength = 0;
function isDestructible(originalBall){
    console.debug("-------isDestructible---------"+originalBall);
    var startDestroyBallLength = destroyBallLength;
    checkLine(originalBall,HORIZONTAL);
    checkLine(originalBall,VERTICAL);
    checkLine(originalBall,LEFT_DIAGONAL);
    checkLine(originalBall,RIGHT_DIAGONAL);
    if(destroyBallLength - startDestroyBallLength>=4){
        destroyBalls[destroyBallLength] = originalBall;
        destroyBallLength++;
        return true;
    }else{
        return false;
    }
}

function destroyBall(){
    for(var i=0; i<destroyBallLength; i++){
        if (board[destroyBalls[i]] != null){
            board[destroyBalls[i]].ballState = DEATH_BALL;
            board[destroyBalls[i]] = null;
        }
    }
    destroyBallLength = 0;
}

function calculateScore(){
    gameGrid.score += destroyBallLength * ballScore;
}

function checkLine(originalBall, type){
    console.debug("Checking line at: "+originalBall+"(col, row):"+getColumn(originalBall)+","+getRow(originalBall)+"type: "+type);
    var currentBall = originalBall;
    var count = 0;
    console.debug("decreasing....");
    while((type == HORIZONTAL && getColumn(currentBall)>0)
          ||(type == VERTICAL && getRow(currentBall)>0)
          ||(type == LEFT_DIAGONAL && getColumn(currentBall)>0&&getRow(currentBall)>0)
          ||(type == RIGHT_DIAGONAL && getColumn(currentBall)<8&&getRow(currentBall)>0)){
        switch(type){
        case HORIZONTAL:
            currentBall = currentBall-1;
            break;
        case VERTICAL:
            currentBall = currentBall- 9;
            break;
        case LEFT_DIAGONAL:
            currentBall = currentBall - 10;
            break;
        case RIGHT_DIAGONAL:
            currentBall = currentBall- 8;
            break;
        }
        console.debug("flood to "+currentBall+"(x, y):"+getColumn(currentBall)+","+getRow(currentBall));
        if (board[currentBall]!=null){
            if ((board[currentBall].ballState==ALIVE_BALL)&&(board[currentBall].type == board[originalBall].type)){
                destroyBalls[destroyBallLength+ count] = currentBall;
                count++;
                console.debug("count to:"+count);
            }
            else{
                break;
            }
        }
        else{
            break;
        }
    }
    console.debug("increasing....");
    currentBall = originalBall;
    while((type == HORIZONTAL && getColumn(currentBall)<8)
          ||(type == VERTICAL && getRow(currentBall)<8)
          ||(type == LEFT_DIAGONAL && getColumn(currentBall)<8&&getRow(currentBall)<8)
          ||(type == RIGHT_DIAGONAL && getColumn(currentBall)>0&&getRow(currentBall)<8)){
        switch(type){
        case HORIZONTAL:
            currentBall = currentBall+1;
            break;
        case VERTICAL:
            currentBall = currentBall+ 9;
            break;
        case LEFT_DIAGONAL:
            currentBall = currentBall + 10;
            break;
        case RIGHT_DIAGONAL:
            currentBall = currentBall+ 8;
            break;
        }
        console.debug("flood to "+currentBall+"(x, y):"+getColumn(currentBall)+","+getRow(currentBall));
        if (board[currentBall]!=null){
            if ((board[currentBall].ballState==ALIVE_BALL)&&(board[currentBall].type == board[originalBall].type)){
                destroyBalls[destroyBallLength+ count] = currentBall;
                count++;
                console.debug("count to:"+count);
            }
            else
            {
                break;
            }
        }else{
            break;
        }
    }
    if(count>=4){
        destroyBallLength = destroyBallLength + count;
    }
}
function nextTurn(){
    var i;
    var initBalls = new Array(3);
    var countBall= 0;
    for(i=0; i<maxIndex; i++){
        var ball= board[i];
        if(ball!=null && ball.ballState==INIT_BALL)
        {
            ball.ballState = ALIVE_BALL;
            initBalls[countBall] = i;
            countBall++;
        }
    }
    if(lackBall){
        initBalls[countBall] = createRandomBall(ALIVE_BALL);
        countBall++;
    }

    for(i=0; i<countBall; i++){
        isDestructible(initBalls[i]);
    }
    destroyBall();

    lackBall = false;
    for(i=0; i<3; i++){
        createRandomBall(INIT_BALL);
    }
}

//Chuyen banh neu duoc. Ko duoc don't care
var finalPath = new Array(maxIndex);;
var pathLength;
var previousBlock = new Array(maxIndex);;
var bfsQueue = new Array(maxIndex);;
var queueLength;
var firstIndex;
function existPath(src,dest){
    for(var i=0; i<maxIndex; i++){
        previousBlock[i] = -1;
    }

    bfsQueue[0] = src;
    firstIndex = 0;
    queueLength = 1;
    pathLength = 0;

    var currentBlock;
    while(firstIndex < queueLength){
        var lastBlock = bfsQueue[firstIndex];
        firstIndex++;
        if(lastBlock%9 != 0){
            currentBlock = lastBlock - 1;
            if(previousBlock[currentBlock]==-1){
                if(currentBlock == dest){
                    previousBlock[dest] = lastBlock;
                    backTrack(src, dest);
                    return true;
                }
                if ((board[currentBlock]==null)||(board[currentBlock]!=null&&board[currentBlock].ballState==INIT_BALL)){
                    flood(lastBlock, currentBlock);
                }
            }
        }
        if(lastBlock%9 != 8){
            currentBlock = lastBlock + 1;
            if(previousBlock[currentBlock]==-1){
                if(currentBlock == dest){
                    previousBlock[dest] = lastBlock;
                    backTrack(src, dest);
                    return true;
                }
                if ((board[currentBlock]==null)||(board[currentBlock]!=null&&board[currentBlock].ballState==INIT_BALL)){
                    flood(lastBlock, currentBlock);
                }
            }
        }

        if(lastBlock - 9 >=0){
            currentBlock = lastBlock - 9;
            if(previousBlock[currentBlock]==-1){

                if(currentBlock == dest){
                    previousBlock[dest] = lastBlock;
                    backTrack(src, dest);
                    return true;
                }
                if ((board[currentBlock]==null)||(board[currentBlock]!=null&&board[currentBlock].ballState==INIT_BALL)){
                    flood(lastBlock, currentBlock);
                }
            }
        }

        if(lastBlock + 9 < maxIndex){
            currentBlock = lastBlock + 9;
            if(previousBlock[currentBlock]==-1){

                if(currentBlock == dest){
                    previousBlock[dest] = lastBlock;
                    backTrack(src, dest);
                    return true;
                }
                if ((board[currentBlock]==null)||(board[currentBlock]!=null&&board[currentBlock].ballState==INIT_BALL)){
                    flood(lastBlock, currentBlock);
                }
            }
        }

    }
}
function displayPath(){
    var currentBlock = pathLength-1;
    while (currentBlock>0){
        repeatTile.itemAt(finalPath[currentBlock]).displayPath = true;
        currentBlock--;
    }
}

function backTrack(src,dest){
    var currentBlock = dest;
    finalPath[0] = dest;
    pathLength = 1;
    while (currentBlock != src){
        finalPath[pathLength] = previousBlock[currentBlock];
        currentBlock = previousBlock[currentBlock];
        pathLength++;
    }
}
function flood(lastBlock, currentBlock){
    previousBlock[currentBlock] = lastBlock;
    bfsQueue[queueLength] = currentBlock;
    queueLength++;
}
function delay(timeInMilliS) {
    var date = new Date();
    var curDate = null;
    do { curDate = new Date(); }
    while(curDate-date < timeInMilliS);
}

function countFreeSlot(){
    var freeSlot = 0;
    for (var i = 0; i<maxIndex; i++){
        if(board[i] == null){
            freeSlot++;
        }
    }
    return freeSlot;
}

function endGameCheck()
{
    var freeSlot = countFreeSlot();
    if(freeSlot<3){
        console.debug("Game over");
    }
}
function createRandomBall(state){
    var freeSlot = countFreeSlot();

    if(freeSlot==0){
        return -1;
    }

    var randomIndex = Math.floor(Math.random()*freeSlot);
    for (var i = 0; i<maxIndex; i++){
        if(board[i] == null){
            if (randomIndex == 0)
            {
                var newBallIndex = i;
                break;
            }
            randomIndex--;
        }
    }
    createSingleBall(newBallIndex, Math.floor(Math.random() * n_BALL_TYPE), state);
    return newBallIndex;
}

function createSingleBall(index,type,inState){
    if(component.status == Component.Ready){
        var block = component.createObject(repeatTile.itemAt(index),
                                           {"type": type,
                                               //"x": column*gameGrid.blockSize,
                                               "width": gameGrid.blockSize,
                                               "height": gameGrid.blockSize});
        if(block == null){
            console.debug("error creating block");
            console.log(component.errorString());
            return false;
        }
        block.ballState = inState;
        board[index] = block;
    }else{
        console.debug("error loading block component");
        console.log(component.errorString());
        return false;
    }
    return true;
}

function saveHighScore(name) {
    if(scoresURL!="")
        sendHighScore(name);
    //OfflineStorage
    var db = openDatabaseSync("SameGameScores", "1.0", "Local SameGame High Scores",100);
    var dataStr = "INSERT INTO Scores VALUES(?, ?, ?, ?)";
    var data = [name, gameGrid.score, maxColumn+"x"+maxRow ,Math.floor(gameDuration/1000)];
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, gridSize TEXT, time NUMBER)');
                    tx.executeSql(dataStr, data);

                    //Only show results for the current grid size
                    var rs = tx.executeSql('SELECT * FROM Scores WHERE gridSize = "'+maxColumn+"x"+maxRow+'" ORDER BY score desc LIMIT 10');
                    var r = "\nHIGH SCORES for this grid size\n\n"
                    for(var i = 0; i < rs.rows.length; i++){
                        r += (i+1)+". " + rs.rows.item(i).name +' got '
                                + rs.rows.item(i).score + ' points in '
                                + rs.rows.item(i).time + ' seconds.\n';
                    }
                    dialog.show(r);
                }
                );
}

function sendHighScore(name) {
    var postman = new XMLHttpRequest()
    var postData = "name="+name+"&score="+gameGrid.score
            +"&gridSize="+maxColumn+"x"+maxRow +"&time="+Math.floor(gameDuration/1000);
    postman.open("POST", scoresURL, true);
    postman.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    postman.onreadystatechange = function() {
                if (postman.readyState == postman.DONE) {
                    dialog.show("Your score has been uploaded.");
                }
            }
    postman.send(postData);
}
