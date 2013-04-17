$(document).ready(function() {
  $('form#tweet').on('submit', function(e) {
    e.preventDefault();
    $form = $(this);
    $errorDiv = $form.find('.errors');
    $.post($form.attr('action'), $form.serialize())
      .done(function(data) {
        $form.find('.errors').empty();
        $('ul.tweets').append('<li>'+data.response+'</li>');
      })
      .error(function(data) {
        $errorDiv.html(data.responseText)
      })
      .always(function() {
        $form[0].reset();
      });
  });
});
