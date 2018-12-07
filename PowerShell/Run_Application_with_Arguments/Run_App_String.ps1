# https://stackoverflow.com/questions/6338015/how-do-you-execute-an-arbitrary-native-command-from-a-string

$command = '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "www.google.com"'
# iex is Invoke-Expression
iex "& $command"