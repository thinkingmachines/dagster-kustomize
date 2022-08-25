values:
	helm repo update dagster
	helm show values dagster/dagster --version ${version} > kustomize/base-values.yaml
	helm show values dagster/dagster-user-deployments --version ${version} > kustomize/base-values-user-code.yaml

infrastructure_base:
	rm -rf kustomize/dagster-infrastructure/base
	helm template --version ${version} dagster dagster/dagster --output-dir kustomize/dagster-infrastructure -f kustomize/base-values.yaml
	mv kustomize/dagster-infrastructure/dagster kustomize/dagster-infrastructure/base
	rm -rf kustomize/dagster-infrastructure/dagster
	cd kustomize/dagster-infrastructure/base; kustomize create --resources charts/postgresql/templates/*,templates/*

user_deployments_base:
	rm -rf kustomize/dagster-user-deployments/base
	helm template --version ${version} dagster-user-deployments dagster/dagster-user-deployments --output-dir kustomize/dagster-user-deployments -f kustomize/base-values-user-code.yaml
	mv kustomize/dagster-user-deployments/dagster-user-deployments/templates kustomize/dagster-user-deployments/base
	rm -rf kustomize/dagster-user-deployments/dagster-user-deployments
	cd kustomize/dagster-user-deployments/base; kustomize create --autodetect

bases: infrastructure_base user_deployments_base

overlays:
	mkdir kustomize/dagster-infrastructure/overlays \
	kustomize/dagster-infrastructure/overlays/staging \
	kustomize/dagster-infrastructure/overlays/production \
	kustomize/dagster-user-deployments/overlays \
	kustomize/dagster-user-deployments/overlays/staging \
	kustomize/dagster-user-deployments/overlays/production