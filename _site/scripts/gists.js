function openLanguage(evt, sectionName, tabName) {
  var tabs = sectionName + "Gists";
  tabcontent = document.getElementById(tabs).children;
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementById(sectionName).children;
  for (i = 0; i < tablinks.length; i++) {
    if (tablinks[i].className.includes("tablinks")) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
  }
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";
} 
