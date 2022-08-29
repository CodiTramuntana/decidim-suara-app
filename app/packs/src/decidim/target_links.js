// Remove target _blank from internal links (with the same host)

document.addEventListener("DOMContentLoaded", function() {
  let links = document.querySelectorAll('a');
  var baseURL = new URL(window.location).origin;

  [].forEach.call(links, function(link) {
    let urlLink = link.getAttribute('href');
    if (isValidUrl(urlLink)) {
      url = new URL(urlLink);
      if (baseURL == url.origin) {
        $(link).removeAttr('target');
      }
    }
  });
});


function isValidUrl(string) {
  let url;
  
  try {
    url = new URL(string);
  } catch (_) {
    return false;  
  }

  return url.protocol === "http:" || url.protocol === "https:";
}
