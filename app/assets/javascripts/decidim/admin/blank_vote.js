function blankVote(element) {
  let translations = JSON.parse(element.getAttribute("value"));

  if (element.checked === true) {
    getInputTitles(true, translations);
  } else {
    getInputTitles(false, translations);
  }
}

function getInputTitles (blankVote, translations) {
  for (let i = 0; i < Object.keys(translations.data).length; i++) { 
    putTitle(Object.values(translations.data)[i], Object.keys(translations.data)[i], blankVote); 
  }
}

function putTitle(element, locale, blankVote) {
  let title = '';
  title = document.getElementById(`response_title_${locale}`);
  title.value = element;
  title.readOnly = blankVote;
}