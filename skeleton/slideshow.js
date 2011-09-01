$(function() {
  var currentSection = $('section').first().fadeIn();
  
  $('body').bind('click keypress', function() {
    currentSection = currentSection.fadeOut().next('section').fadeIn(); 
  });
});
