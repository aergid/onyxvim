let
  normal = opts: map (x:
    x // opts // {
      mode = "n";
    }
  );

  visual = opts: map (x:
    x // opts // {
      mode = "n";
    }
  );

in
{
  keymaps = {
    silent = {
      normal = normal { options.silent = true; };
      visual = visual { options.silent = true; };
    };
    verbose = {
      normal = normal { options.silent = false; };
      visual = visual { options.silent = false; };
    };
  };

}
