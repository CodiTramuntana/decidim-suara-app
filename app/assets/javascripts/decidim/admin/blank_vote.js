const PLACEHOLDERS_ES = [
  'Voto en blanco',
  'Blank vote',
  'Vot en blanc'
];

const PLACEHOLDERS_CA = [
  'Vot en blanc',
  'Blank vote',
  'Voto en blanco'
];

const PLACEHOLDERS_EN = [
  'Blank vote',
  'Vot en blanc',
  'Voto en blanco'
];

function blankVote(element) {
  if (element.checked === true) {
    getInputTitles(true);
  } else {
    getInputTitles(false);
  }
}

function getInputTitles (blankVote) {
  const languageElement = document.getElementById('admin-user-menu');
  const language = languageElement.parentElement.getAttribute("aria-label");

  if (language === 'Castellano') {
    PLACEHOLDERS_ES.forEach((element, index) => { putTitle(element, index, blankVote); });
  } else if (language === 'English') {
    PLACEHOLDERS_EN.forEach((element, index) => { putTitle(element, index, blankVote); });
  } else {
    PLACEHOLDERS_CA.forEach((element, index) => { putTitle(element, index, blankVote); });
  }
}

function putTitle(element, index, blankVote) {
  let title = '';
  title = document.getElementById(`response-title-tabs-title-panel-${index}`).firstChild;
  title.value = element;
  title.readOnly = blankVote;
}