NDC_REST_VERSION ?= v0.2.0
ORY_HYDRA_VERSION ?= v2.2.0
UID ?= $(shell id -u)
GID ?= $(shell id -g)

.PHONY: build-schema
build-schema:
	go install github.com/hasura/ndc-rest-schema@v0.2.0
	ndc-rest-schema convert \
		-c schema/public/config.yaml \
		-o config/schema-public.json
	/ndc-rest-schema convert \
		-c schema/admin/config.yaml \
		-o config/schema-admin.json

.PHONY: update-deps
update-deps:
	VERSION=$(NDC_REST_VERSION) ORY_HYDRA_VERSION=$(ORY_HYDRA_VERSION) scripts/update-deps.sh