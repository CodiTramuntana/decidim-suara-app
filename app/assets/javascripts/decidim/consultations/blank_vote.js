
function multipleVote(checkbox) {
  const checkboxes = document.querySelectorAll('form .multiple_votes_form input[type="checkbox"]');
  let remainingVotesCount = document.getElementById('remaining-votes-count');
  let max = parseInt(remainingVotesCount.textContent, 10);

  if (checkbox.checked && checkbox.getAttribute('blank_vote') === 'true') {
    checkboxes.forEach(element => {
      if (element !== checkbox) {
        if (element.checked == true) {
          max += 1;
          remainingVotesCount.textContent = max;
        }
        element.checked = false;
        element.disabled = true;
      }
    });
  } else if (!checkbox.checked && checkbox.getAttribute('blank_vote') === 'true') {
    checkboxes.forEach(element => {
      if (element !== checkbox) {
        if (element.checked == true) {
          max += 1;
          remainingVotesCount.textContent = max;
        }
        element.disabled = false;
        element.checked = false;
      }
    });
  }
}