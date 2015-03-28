(function() {
  var addAccount, loginAccount, milkcocoa;

  milkcocoa = new MilkCocoa("https://io-zi7rx7zso.mlkcca.com:443");

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
    milkcocoa.login(email, password, function(err, user) {
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
          alert("a");
      }
    });
  };

  $('#sign-up-btn').click(function() {
    addAccount($('#input-sign-up-Email').val(), $('#input-sign-up-Password').val());
  });

  $('#sign-in-btn').click(function() {
    loginAccount($('#input-sign-in-Email').val(), $('#input-sign-in-Password').val());
  });

}).call(this);
