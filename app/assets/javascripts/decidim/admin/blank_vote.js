const PLACEHOLDER_ES = 'Voto en blanco';
const PLACEHOLDER_CA = 'Vot en blanc';
const PLACEHOLDER_EN = 'Blank vote';

function blankVote(element) {
  if (element.checked === true) {
    getInputTitles(true);
  } else {
    getInputTitles(false);
  }
}

function getInputTitles (blankVote) {
  const languageTitles = document.getElementById('response-title-tabs').getElementsByTagName('li');

  for (let i = 0; i < languageTitles.length; i++) {
    let element = languageTitles[i];
    switch (element.innerText) {
      case 'Castellano':
        putTitle(PLACEHOLDER_ES, i, blankVote);
        break;
      case 'Català':
        putTitle(PLACEHOLDER_CA, i, blankVote);
        break;
      case 'English':
        putTitle(PLACEHOLDER_EN, i, blankVote);
        break;
    }
  }
}

function putTitle(element, index, blankVote) {
  let title = '';
  title = document.getElementById(`response-title-tabs-title-panel-${index}`).firstChild;
  title.value = element;
  title.readOnly = blankVote;
}