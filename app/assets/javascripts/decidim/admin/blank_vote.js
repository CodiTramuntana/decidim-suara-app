function blankVote(element) {
  let translations = JSON.parse(element.getAttribute("value"));

  if (element.checked === true) {
    getInputTitles(true, translations);
  } else {
    getInputTitles(false, translations);
  }
}

function getInputTitles (blankVote, translations) {
  const languageTitles = document.getElementById('response-title-tabs').getElementsByTagName('li');

  for (let i = 0; i < languageTitles.length; i++) {
    let element = languageTitles[i];
    switch (element.innerText) {
      case 'Castellano':
        putTitle(translations.data.es, i, blankVote);
        break;
      case 'Català':
        putTitle(translations.data.ca, i, blankVote);
        break;
      case 'English':
        putTitle(translations.data.en, i, blankVote);
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