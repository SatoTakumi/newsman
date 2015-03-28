(function() {
  var addAccount, blogBasicInfoStore, blogPostDataStore, getBlogTag, init, loginAccount, milkcocoa, user_email;

  milkcocoa = new MilkCocoa("https://io-zi7rx7zso.mlkcca.com:443");

  user_email = "";

  blogBasicInfoStore = milkcocoa.dataStore('blogInfo');

  blogPostDataStore = milkcocoa.dataStore('blogPost');

  init = function() {
    blogBasicInfoStore.child('blogInfo').get(function(data) {
      $('.blog-title').text(data.blog_title);
      $('#blog-title-edit').val(data.blog_title);
      $('.blog-description').text(data.blog_description);
      $('#blog-description-edit').val(data.blog_description);
    });
    blogPostDataStore.query().done(function(data) {
      console.log(data);
      $.each(data, function(i, val) {
        console.log(i + ': ' + val.title);
        $('.blog-main').prepend(getBlogTag(val.title, val.body));
      });
    });
  };

  init();

  addAccount = function(email, password) {
    milkcocoa.addAccount(email, password, null, function(err, user) {
      switch (err) {
        case null:
          console.log("Success Reg");
          $('#alerts').html('<div class="alert alert-success" role="alert">Success Registe</div>');
          break;
        case MilkCocoa.Error.AddAccount.FormatError:
          console.log("Invalid Email validation.");
          $('#alerts').html('<div class="alert alert-warning" role="alert">Invalid Email</div>');
          break;
        case MilkCocoa.Error.AddAccount.AlreadyExist:
          console.log("e-mail has already regist.");
          $('#alerts').html('<div class="alert alert-danger" role="alert">This Email has already registered</div>');
      }
    });
  };

  loginAccount = function(email, password) {
    return milkcocoa.login(email, password, function(err, user) {
      switch (err) {
        case MilkCocoa.Error.Login.FormatError:
          console.log("Invalid Email validation");
          $('#alerts').html('<div class="alert alert-warning" role="alert">Invalid Email</div>');
          break;
        case MilkCocoa.Error.Login.LoginError:
          console.log("This account is not registerd or password is wrong.");
          $('#alerts').html('<div class="alert alert-warning" role="alert">This account is not registerd or password is wrong.</div>');
          break;
        case MilkCocoa.Error.Login.EmailNotVerificated:
          console.log("This account is provisional registration.");
          $('#alerts').html('<div class="alert alert-warning" role="alert">This account is provisional registration.</div>');
          break;
        default:
          window.location.href = "index.html";
      }
    });
  };

  getBlogTag = function(title, body) {
    var blogTag;
    blogTag = '<div class="blog-post">' + '<h2 class="blog-post-title">' + title + '</h2>' + '<p class="blog-post-meta">January 1, 2014 by <a href="#">Mark</a></p>' + body + '</div>';
    return blogTag;
  };

  milkcocoa.getCurrentUser(function(err, user) {
    switch (err) {
      case MilkCocoa.Error.GetCurrentUser.NotLoggedIn:
        return;
    }
    if (user.id) {
      $(".edit-btn").show();
      $("#post-box").show();
    }
  });

  $('#sign-up-btn').click(function() {
    addAccount($('#input-sign-up-Email').val(), $('#input-sign-up-Password').val());
  });

  $('#sign-in-btn').click(function() {
    loginAccount($('#input-sign-in-Email').val(), $('#input-sign-in-Password').val());
  });

  $('#blog-title-edit-btn').click(function() {
    $('.blog-title').toggle();
    $('#blog-title-edit').toggle();
    blogBasicInfoStore.set("blogInfo", {
      blog_title: $('#blog-title-edit').val()
    });
    $('.blog-title').text($('#blog-title-edit').val());
  });

  $('#blog-description-edit-btn').click(function() {
    $('.blog-description').toggle();
    $('#blog-description-edit').toggle();
    blogBasicInfoStore.set("blogInfo", {
      blog_description: $('#blog-description-edit').val()
    });
    $('.blog-description').text($('#blog-description-edit').val());
  });

  $('#post-submit').click(function() {
    blogPostDataStore.push({
      title: $('#post-title').val(),
      body: $('#post-body').val()
    });
    $('.blog-main').prepend(getBlogTag($('#post-title').val(), $('#post-body').val()));
    $('#post-title').val('');
    $('#post-body').val('');
  });

  $('#logout').click(function() {
    milkcocoa.logout();
    window.location.reload();
  });

}).call(this);
