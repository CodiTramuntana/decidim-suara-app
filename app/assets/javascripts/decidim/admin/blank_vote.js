const PLACEHOLDERS = [
  'Voto en blanco',
  'Blank vote',
  'Vot en blanc'
];

function blankVote(element) {
  if (element.checked === true) {
    getInputTitles(true);
  } else {
    getInputTitles(false);
  }
}

function getInputTitles (blankVote) {
  PLACEHOLDERS.forEach((element, index) => {
    let title = '';
    title = document.getElementById(`response-title-tabs-title-panel-${index}`).firstChild;
    title.value = element;
    title.readOnly = blankVote;
  });
}