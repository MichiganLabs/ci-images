
all: python android

push-all: push-python push-android

## PYTHON ##

PYTHONS = 3.8 3.9 3.10
python: $(addprefix build-py-,$(PYTHONS))
push-python: $(addprefix push-py-,$(PYTHONS))

build-py-%:
	docker build ./python --build-arg VERSION=$* -t michiganlabs/python:$*

push-py-%:
	docker push michiganlabs/python:$*

## Android ##

ANDROID_SDKS = 30 31
android: $(addprefix build-android-,$(ANDROID_SDKS))
push-android: $(addprefix push-android-,$(ANDROID_SDKS))

build-android-%:
	docker build ./android --build-arg ANDROID_SDK_VERSION=$* -t michiganlabs/android:$*

push-android-%:
	docker push michiganlabs/android:$*


## Android using Java 8 ##
android-jdk8: $(addprefix build-android-jdk8-,$(ANDROID_SDKS))
push-android-jdk8: $(addprefix push-android-jdk8-,$(ANDROID_SDKS))

build-android-jdk8-%:
	docker build ./android-jdk8 --build-arg ANDROID_SDK_VERSION=$* -t michiganlabs/android-jdk8:$*

push-android-jdk8-%:
	docker push michiganlabs/android-jdk8:$*
