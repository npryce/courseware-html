$(function() {
    var bindings = {
        next: ['right', 'down', 'space', 'pagedown'],
        prev: ['left', 'up', 'pageup'],
        first: ['home', 'Ctrl+left', 'Ctrl+up'],
        last: ['end', 'Ctrl+right', 'Ctrl+down']
    };
    
    var slide_selector = 'section.courseware-slide';
    
    function initialSlide() {
      var slides = $(slide_selector);
      
      var index = Math.max(1, Math.min(parseInt(document.location.hash.slice(1), 10), slides.length));
      if (isNaN(index)) {
        index = 1;
      }
      
      return slides.eq(index-1);
    }
    
    var currentSlide = initialSlide();
    
    function transition(fromSlide, toSlide) {
      fromSlide.fadeOut();
      toSlide.fadeIn();
    }
    
    function changeSlideTo(selectNext) {
      var nextSlide = selectNext(currentSlide);
      
      if (nextSlide.length != 0) {
	transition(currentSlide, nextSlide);
        currentSlide.trigger("slideHidden");
	currentSlide = nextSlide;
	document.location.hash = currentSlide.attr('id');
        currentSlide.trigger("slideShown");
      }
    }
    
    function gotoSlideAction(whereTo) {
      return function(event) {
	changeSlideTo(whereTo);
	return false;
      }
    }
    
    function fontSizeForWidth(width) {
      return width/40;
    }
    
    function resizeFontToFitWindow() {
      var body = $(document.body);
      body.css('font-size', fontSizeForWidth(body.width()) + "px");
    }
    
    function startScrollingCredits() {
        console.log("startScrollingCredits");
    }

    function stopScrollingCredits() {
        console.log("stopScrollingCredits");
    }

    var traversals = {
        next: function(slide) {
            return slide.next(slide_selector);
        },
        prev: function(slide) {
	    return slide.prev(slide_selector);
        },
        first: function(slide) {
            return $(slide_selector).first();
        }, 
        last: function(slide) {
	    return $(slide_selector).last();
        }
    };
    
    for (var name in bindings) {
      var traversal = traversals[name];
      for (var index in bindings[name]) {
	$(document).bind('keydown', bindings[name][index], gotoSlideAction(traversal));
      }
    }
    
    $(window).bind('resize', resizeFontToFitWindow);
    $('.courseware-credits-slide').bind({
      slideShown: startScrollingCredits,
      slideHidden: stopScrollingCredits
    });
    
    resizeFontToFitWindow();
    prettyPrint();
    currentSlide.fadeIn();    
});
