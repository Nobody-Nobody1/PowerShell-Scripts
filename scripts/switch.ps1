# skip args[0] since it's the tool selection argument
$version = $args[1]

if ($version -eq "7") {
    # set active engine to PowerShell 7
    # save choice (file or env variable)
    # print confirmation
}
elseif ($version -eq "5") {
    # set active engine to Windows PowerShell 5.1
    # save choice
    # print confirmation
}
else {
    # show help
    # explain valid options
}