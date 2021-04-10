
all: python android

push-all: push-python push-android

## PYTHON ##

PYTHONS = 3.6 3.7 3.8 3.9
python: $(addprefix build-py-,$(PYTHONS))
push-python: $(addprefix push-py-,$(PYTHONS))

build-py-%:
	docker build ./python --build-arg VERSION=$* -t michiganlabs/python:$*

push-py-%:
	docker push michiganlabs/python:$*

## Android ##

ANDROID_SDKS = 29 30
android: $(addprefix build-android-,$(ANDROID_SDKS))
push-android: $(addprefix push-android-,$(ANDROID_SDKS))

build-android-%:
	docker build ./android --build-arg ANDROID_SDK_VERSION=$* -t michiganlabs/android:$*

push-android-%:
	docker push michiganlabs/android:$*
