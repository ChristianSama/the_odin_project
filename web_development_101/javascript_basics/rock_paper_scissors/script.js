buttons = document.querySelectorAll('.btn');

buttons.forEach(button => {
    button.addEventListener('click', play)
});

function play() { //runs game
    let playerSel = this.getAttribute('id');
    let computerSel = computerPlay();
    displayComputerSel(computerSel);
    result = checkWin(playerSel, computerSel);
    displayWinner(result);
};

function random(number) { //returns a random number between 0 and x
    return Math.floor(Math.random()*number);
}

function computerPlay() { //returns a random option
    options = ['rock',
               'paper',
               'scissors'];
    return options[Math.floor(Math.random()*options.length)] 
}

function checkWin(playerSel, computerSel) {  //Checks win conditions (win = 1; lose = 2; tie = 0)
    switch (true) {
        case (playerSel === 'rock' && computerSel === 'scissors'):
            return 1;
        case (playerSel === 'rock' && computerSel === 'paper'):
            return 2;
        case (playerSel === 'paper' && computerSel === 'rock'):
            return 1;
        case (playerSel === 'paper' && computerSel === 'scissors'):
            return 2;
        case (playerSel === 'scissors' && computerSel === 'paper'):
            return 1;
        case (playerSel === 'scissors' && computerSel === 'rock'):
            return 2;
        default:
            return 0;
    }
};

function displayComputerSel(compPlay) { //updates html img 
    let images = ['https://images.vexels.com/media/users/3/145827/isolated/preview/357f06ecbaaa77d750259c459c0ed55f-round-rock-illustration-by-vexels.png',
                  'https://images.assetsdelivery.com/compings_v2/dvarg/dvarg1311/dvarg131100030.jpg',
                  'https://previews.123rf.com/images/lhfgraphics/lhfgraphics1112/lhfgraphics111200071/11575045-doodle-style-scissors-illustration.jpg'];
    
    let computerImg = document.querySelector('#compImg');

    if (compPlay === 'rock') {
        computerImg.src = images[0]
    } else if (compPlay === 'paper') {
        computerImg.src = images[1]
    } else {
        computerImg.src = images[2]
    }
};

function displayWinner(result) {
    winnerText = document.querySelector('.winner');

    if (result === 1) {
        winnerText.textContent = 'YOU WIN!';
    } else if (result === 2) {
        winnerText.textContent = 'YOU LOSE!';
    } else {
        winnerText.textContent = 'TIE!';
    }
}
