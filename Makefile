IMAGENAME=ct-registry.activision.com/perforce/p4-exporter
DOCKER_LABEL?=test
TAG=$(DOCKER_LABEL)


exporter: image
	docker-compose up -d
	docker-compose logs -f

stop:
	docker-compose down

image:
	docker build -t $(IMAGENAME):$(TAG) .

push:
	docker push $(IMAGENAME):$(TAG)

login:
	docker login -u $(REG_USERNAME) -p $(REG_PASSWORD) ct-registry.activision.com

test:
	@echo "No tests configured"

jenkins_test: image test

jenkins_test_integration: jenkins_test

jenkins_publish: image test login push
