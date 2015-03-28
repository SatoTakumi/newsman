milkcocoa = new MilkCocoa "https://io-zi7rx7zso.mlkcca.com:443"
user_email = "";
blogBasicInfoStore = milkcocoa.dataStore('blogInfo')
blogPostDataStore = milkcocoa.dataStore('blogPost')

init = () ->
  blogBasicInfoStore.child('blogInfo').get (data) ->
    #BlogTitle
    $('.blog-title').text(data.blog_title)
    $('#blog-title-edit').val(data.blog_title)
    #BlogDescription
    $('.blog-description').text(data.blog_description)
    $('#blog-description-edit').val(data.blog_description)
    return
  blogPostDataStore.query().done (data) ->
    console.log data
    $.each data, (i, val) ->
      console.log i + ': ' + val.title
      $('.blog-main').prepend(getBlogTag(val.title,val.body))
      return
    return
  return
init()
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
        window.location.href = "index.html"
    return

getBlogTag = (title,body) ->
  blogTag =
      '<div class="blog-post">' +
        '<h2 class="blog-post-title">'+title+'</h2>' +
        '<p class="blog-post-meta">January 1, 2014 by <a href="#">Mark</a></p>' +
        body+
      '</div>'
  return blogTag

#ユーザがログインしているか
milkcocoa.getCurrentUser (err, user) ->
  switch err
    when MilkCocoa.Error.GetCurrentUser.NotLoggedIn
      return
  if user.id
    $(".edit-btn").show();
    $("#post-box").show();
  return
#-----------------------------------------#
# Events
#-----------------------------------------#
$('#sign-up-btn').click ->
  addAccount $('#input-sign-up-Email').val(),$('#input-sign-up-Password').val()
  return
$('#sign-in-btn').click ->
  loginAccount $('#input-sign-in-Email').val(),$('#input-sign-in-Password').val()
  return

#Blog title edit
$('#blog-title-edit-btn').click ->
  $('.blog-title').toggle()
  $('#blog-title-edit').toggle()

  blogBasicInfoStore.set "blogInfo",blog_title:$('#blog-title-edit').val()
  $('.blog-title').text($('#blog-title-edit').val())
  return

#Blog description
$('#blog-description-edit-btn').click ->
  $('.blog-description').toggle()
  $('#blog-description-edit').toggle()

  blogBasicInfoStore.set "blogInfo",blog_description:$('#blog-description-edit').val()
  $('.blog-description').text($('#blog-description-edit').val())
  return

#Blog Post
$('#post-submit').click ->
  blogPostDataStore.push
    title: $('#post-title').val(),
    body: $('#post-body').val()
  $('.blog-main').prepend(getBlogTag($('#post-title').val(),$('#post-body').val()))
  $('#post-title').val('')
  $('#post-body').val('')
  return

$('#logout').click ->
  milkcocoa.logout();
  window.location.reload();
  return
