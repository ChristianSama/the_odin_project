function random(number) {
    return Math.floor(Math.random()*number);
}

function computerPlay() {
    options = ['rock',
               'paper',
               'scissors'];
    return options[Math.floor(Math.random()*options.length)]
}

function play(playerSel, computerSel) {

    switch (true) {
        case (playerSel.toLowerCase() === 'rock' && computerSel.toLowerCase() === 'scissors'):
            return 1;
        case (playerSel.toLowerCase() === 'rock' && computerSel.toLowerCase() === 'paper'):
            return 2;
        case (playerSel.toLowerCase() === 'paper' && computerSel.toLowerCase() === 'rock'):
            return 1;
        case (playerSel.toLowerCase() === 'paper' && computerSel.toLowerCase() === 'scissors'):
            return 2;
        case (playerSel.toLowerCase() === 'scissors' && computerSel.toLowerCase() === 'paper'):
            return 1;
        case (playerSel.toLowerCase() === 'scissors' && computerSel.toLowerCase() === 'rock'):
            return 2;
        default:
            return 0;
    }
}      

function game() {
    let playerSelection, computerSelection;
    let playerScore = 0;
    let computerScore = 0;
    let result, score, str;
    
    for (let i = 0; i < 5; i++){
        playerSelection = prompt('Choose: Rock, Paper or Scissors');
        computerSelection = computerPlay();
        result = play(playerSelection, computerSelection);
        str = `You: ${playerSelection}\nComputer: ${computerSelection}\n`;
        console.log('------- ROUND ' + (i+1)+ '-------')
        if (result === 1) {
            playerScore++;
            console.log(str + 'You Won!');
        } else if (result === 2) {
            computerScore++;
            console.log(str + 'You Lose!');
        } else {
            console.log(str + 'Tie!');
        }

        score = `You: ${playerScore}\nComputer: ${computerScore}`;
        console.log(score);
    }
}
game();