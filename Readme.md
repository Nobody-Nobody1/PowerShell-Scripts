# Windows Only Scripts
- add folder to PATH after cloning.
- most scripts won't need any admin rights unless needed which is going to be specified in the first line as a comment.
- when making scripts that take arguments, leave args[0] alone since that's used for selecting which file to run.
- This is because of how the cmd launcher file is set up to be dynamic and it uses args[0] as a way to select it