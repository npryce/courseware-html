$(function() {
    var currentSlide = $('section').first();
    
    function transition(fromSlide, toSlide) {
      fromSlide.fadeOut();
      toSlide.fadeIn();
    }
    
    function changeSlideTo(selectNext) {
      var nextSlide = selectNext(currentSlide);
      
      transition(currentSlide, nextSlide);
      currentSlide = nextSlide;
      document.location.hash = currentSlide.attr('id');
    }
    
    function gotoSlideAction(whereTo) {
      return function(event) {
	changeSlideTo(whereTo);
	return false;
      }
    }
    
    var traversals = {
        next: function(slide) {
            return slide.next('section');
        },
        prev: function(slide) {
	    return slide.prev('section');
        },
        first: function(slide) {
            return slide.siblings('section').first();
        }, 
        last: function(slide) {
	    return slide.siblings('section').last();
        }
    };
    
    var bindings = {
        next: ['right', 'down', 'space'],
        prev: ['left', 'up'],
        first: ['home', 'Ctrl+left', 'Ctrl+up'],
        last: ['end', 'Ctrl+right', 'Ctrl+down']
    };
    
    for (var name in bindings) {
      var traversal = traversals[name];
      for (var index in bindings[name]) {
	$(document).bind('keydown', bindings[name][index], gotoSlideAction(traversal));
      }
    }
    
    prettyPrint();
    currentSlide.fadeIn();
});
