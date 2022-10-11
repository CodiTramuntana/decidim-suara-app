function blankVote(element) {
  let translations = JSON.parse(element.getAttribute("data-attribute"));

  if (element.checked === true) {
    getInputTitles(true, translations);
  } else {
    getInputTitles(false, translations);
  }
}

function getInputTitles (blankVote, translations) {
  for (let i = 0; i < Object.keys(translations).length; i++) { 
    putTitle(Object.values(translations)[i], Object.keys(translations)[i], blankVote); 
  }
}

function putTitle(element, locale, blankVote) {
  let title = '';
  title = document.getElementById(`response_title_${locale}`);
  title.value = element;
  title.readOnly = blankVote;
}