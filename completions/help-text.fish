alias common-complete 'complete --command=help-text --no-files'

common-complete
common-complete --long=help --short=h --description='Show this reference manual'
common-complete --long=positional --short=p --description='Individual positional args' --exclusive
common-complete --long=switch --short=s --description='Individual switches' --exclusive
