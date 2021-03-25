let div;

const container = document.querySelector('.container');

init();

function init() {
    let size = 16;
    createGrid(size);
    addEventBoxes();
}

function createGrid(size) {
    deleteAllChilds();
    for (let i = 1; i <= (size*size); i++) {
        div = document.createElement('div');
        div.classList.add('item' + i);
        div.classList.add('box');
        container.appendChild(div);
    }

    let str = '';
    for (let i = 1; i <= size; i++) {
        str += ' 1fr';
    }
    str += ';';
    container.setAttribute('style', 'grid-template-columns:' + str + 'grid-template-rows:' + str);
}

function addEventBoxes() {
    const boxes = document.querySelectorAll('.box');

    boxes.forEach((box) => {
        box.addEventListener('mouseenter', (e) => {
            e.target.classList.add('active');
        })
    })
}

function deleteAllChilds() {
    let child = container.lastElementChild;
    while (child) {
        container.removeChild(child);
        child = container.lastElementChild;
    }
}

const button = document.querySelector('#btn-resize');

button.addEventListener('click', () => {
    let size;
    do {
        size = parseInt(window.prompt('How many squares per side?', '16'));
    }while(isNaN(size))
    createGrid(size);
    addEventBoxes();
});

const resetButton = document.querySelector('#btn-reset');
resetButton.addEventListener('click', () => {
    resetBoxes();
});

function resetBoxes() {
    const boxes = document.querySelectorAll('.box');

    boxes.forEach((box) => {
        box.classList.remove('active');
    })
}