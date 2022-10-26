const checkboxBlankVote = document.querySelector('form input[type="checkbox"]');

checkboxBlankVote.addEventListener('change', function() {
  let translations = JSON.parse(this.getAttribute("data-attribute"));
  
  if (this.checked === true) {
    getInputTitles(true, translations);
  } else {
    getInputTitles(false, translations);
  }
})

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
