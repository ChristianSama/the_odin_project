const container = document.querySelector('#container');

const content = document.createElement('div');
content.classList.add('content');
content.textContent = 'This is the glorious text-content!';

container.appendChild(content);

const redText = document.createElement('p');
redText.textContent = 'Hey I\'m red!';
redText.style.color = 'red';
container.appendChild(redText);

const blueText = document.createElement('h3');
blueText.textContent = 'I\'m blue h3!';
blueText.style.color = 'blue';
container.appendChild(blueText);

const pinkDiv = document.createElement('div');
pinkDiv.style.backgroundColor = 'pink';
pinkDiv.style.border = '2px solid black';
container.appendChild(pinkDiv);

const newDiv = document.createElement('h1');
newDiv.textContent = 'I\'m a div';
pinkDiv.appendChild(newDiv);

const newPara = document.createElement('p');
newPara.textContent = 'ME TOO!';
pinkDiv.appendChild(newPara);


btn.addEventListener('click', function (e) {
    console.log(e.target);
  });

btn.addEventListener('click', function (e) {
    e.target.style.background = 'blue';
  });
