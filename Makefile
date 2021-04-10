
all: python
push-all: push-python

## PYTHON ##

PYTHONS = 3.6 3.7 3.8 3.9
python: $(addprefix build-py-,$(PYTHONS))
push-python: $(addprefix push-py-,$(PYTHONS))

build-py-%:
	docker build ./python --build-arg VERSION=$* -t michiganlabs/python:$*

push-py-%:
	docker push michiganlabs/python:$*
