$(document).ready(function() {

  $('.interest-menu').click(function() {
    $('.interest-menu').removeClass('selected');
    $(this).toggleClass('selected');
    var interestId = $(this).data('interest');
    $('.event-listings').hide();
    $('.event-listings[data-interest=' + interestId + ']').show();
    });


  $('#all-events').click(function() {
    $('.event-listings').show();
    });
});
