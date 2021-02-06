
l10n-compile:
	 npm run localize-compile 
	
l10n-extract:
	npm run localize-extract

lock:
	pipenv run pip freeze > requirements.txt