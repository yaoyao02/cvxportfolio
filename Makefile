BUILDDIR      = build
PYTHON        = python
ENVDIR        = env


.PHONY: env docs clean test cleanenv
	
env:
	$(PYTHON) -m venv $(ENVDIR)
	$(ENVDIR)/bin/$(PYTHON) -m pip install -r requirements.txt
	$(ENVDIR)/bin/$(PYTHON) -m pip install --editable .
	
test:
	$(ENVDIR)/bin/$(PYTHON) -m unittest cvxportfolio/tests/*.py

clean:
	-rm -rf $(BUILDDIR)/* 
	
cleanenv:
	-rm -rf $(ENVDIR)/*

docs:
	$(ENVDIR)/bin/sphinx-build -E docs $(BUILDDIR); open build/index.html
	
revision:
	$(ENVDIR)/bin/$(PYTHON) bumpversion.py revision	
	git push
	$(ENVDIR)/bin/$(PYTHON) setup.py sdist bdist_wheel
	twine upload dist/*

minor:
	$(ENVDIR)/bin/$(PYTHON) bumpversion.py minor	
	git push
	$(ENVDIR)/bin/$(PYTHON) setup.py sdist bdist_wheel
	twine upload dist/*

major:
	$(ENVDIR)/bin/$(PYTHON) bumpversion.py major	
	git push
	$(ENVDIR)/bin/$(PYTHON) setup.py sdist bdist_wheel
	twine upload dist/*