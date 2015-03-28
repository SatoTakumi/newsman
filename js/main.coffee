milkcocoa = new MilkCocoa "https://io-zi7rx7zso.mlkcca.com:443"

#アカウントを登録する
addAccount = (email,password) ->
  milkcocoa.addAccount email,password,null,(err,user) ->
    switch err
      when null
        console.log "Success Reg"
        $('#alerts').html '<div class="alert alert-success" role="alert">Success Registe</div>'
      when MilkCocoa.Error.AddAccount.FormatError
        console.log "Invalid Email validation."
        $('#alerts').html '<div class="alert alert-warning" role="alert">Invalid Email</div>'
      when MilkCocoa.Error.AddAccount.AlreadyExist
        console.log "e-mail has already regist."
        $('#alerts').html '<div class="alert alert-danger" role="alert">This Email has already registered</div>'
    return
  return
loginAccount = (email,password) ->
  milkcocoa.login email,password,(err,user) ->
    switch err
      when MilkCocoa.Error.Login.FormatError
        console.log "Invalid Email validation"
        $('#alerts').html '<div class="alert alert-warning" role="alert">Invalid Email</div>'
      when MilkCocoa.Error.Login.LoginError
        console.log "This account is not registerd or password is wrong."
        $('#alerts').html '<div class="alert alert-warning" role="alert">This account is not registerd or password is wrong.</div>'
      when MilkCocoa.Error.Login.EmailNotVerificated
        console.log "This account is provisional registration."
        $('#alerts').html '<div class="alert alert-warning" role="alert">This account is provisional registration.</div>'
      else
        alert "a"
    return
  return

#ユーザがログインしているか

#-----------------------------------------#
# Events
#-----------------------------------------#
$('#sign-up-btn').click ->
  addAccount $('#input-sign-up-Email').val(),$('#input-sign-up-Password').val()
  return
$('#sign-in-btn').click ->
  loginAccount $('#input-sign-in-Email').val(),$('#input-sign-in-Password').val()
  return
