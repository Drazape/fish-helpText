set --local -- common_complete complete --command=help-text --no-files

$common_complete
$common_complete --long=help --short=h --description='Show this reference manual'
$common_complete --long=positional --short=p --description='Individual positional args' --exclusive
$common_complete --long=switch --short=s --description='Individual switches' --exclusive
