$("form#login-box").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      //javascript that executes if everything goes o.k.
      $('#sign_in').modal('hide')
      $('#sign_in_button').hide()
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert('failure!')
;
