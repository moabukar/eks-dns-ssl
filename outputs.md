# Outputs for EXT DNS and Cert man

## ExtDNS

- ExternalDNS automates the adding of records 

```bash
time="2024-08-18T12:58:30Z" level=info msg="Instantiating new Kubernetes client"
time="2024-08-18T12:58:30Z" level=info msg="Using inCluster-config based on serviceaccount-token"
time="2024-08-18T12:58:30Z" level=info msg="Created Kubernetes client https://172.20.0.1:443"
time="2024-08-18T12:58:32Z" level=info msg="Applying provider record filter for domains: [lab.moabukar.co.uk. .lab.moabukar.co.uk.]"
time="2024-08-18T12:58:32Z" level=info msg="All records are already up to date"
time="2024-08-18T12:59:31Z" level=info msg="Applying provider record filter for domains: [lab.moabukar.co.uk. .lab.moabukar.co.uk.]"
time="2024-08-18T12:59:31Z" level=info msg="Desired change: CREATE argocd.lab.moabukar.co.uk A [Id: /hostedzone/Z03166542V7F6LVUK1OV0]"
time="2024-08-18T12:59:31Z" level=info msg="Desired change: CREATE argocd.lab.moabukar.co.uk TXT [Id: /hostedzone/Z03166542V7F6LVUK1OV0]"
time="2024-08-18T12:59:31Z" level=info msg="Desired change: CREATE cname-argocd.lab.moabukar.co.uk TXT [Id: /hostedzone/Z03166542V7F6LVUK1OV0]"
time="2024-08-18T12:59:31Z" level=info msg="3 record(s) in zone lab.moabukar.co.uk. [Id: /hostedzone/Z03166542V7F6LVUK1OV0] were successfully updated"
time="2024-08-18T13:00:32Z" level=info msg="Applying provider record filter for domains: [lab.moabukar.co.uk. .lab.moabukar.co.uk.]"
time="2024-08-18T13:00:32Z" level=info msg="All records are already up to date"
```


## Cert manager

- Cert manager verifies you first own the domain and then creates a temporary TXT record in your DNS Zone and in our case Route53. Cert manager does a DNS Challenge and checks it and then it gives you the lets encrypt certificate. 

```bash
I0818 12:59:53.163972       1 conditions.go:203] Setting lastTransitionTime for Certificate "argocd-ingress-tls" condition "Ready" to 2024-08-18 12:59:53.163887717 +0000 UTC m=+73.618704152
I0818 12:59:53.165795       1 trigger_controller.go:215] "Certificate must be re-issued" logger="cert-manager.controller" key="argocd/argocd-ingress-tls" reason="DoesNotExist" message="Issuing certificate as Secret does not exist"
I0818 12:59:53.165900       1 conditions.go:203] Setting lastTransitionTime for Certificate "argocd-ingress-tls" condition "Issuing" to 2024-08-18 12:59:53.16589287 +0000 UTC m=+73.620709295
I0818 12:59:53.204153       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls" error="Operation cannot be fulfilled on certificates.cert-manager.io \"argocd-ingress-tls\": the object has been modified; please apply your changes to the latest version and try again"
I0818 12:59:53.204258       1 trigger_controller.go:215] "Certificate must be re-issued" logger="cert-manager.controller" key="argocd/argocd-ingress-tls" reason="DoesNotExist" message="Issuing certificate as Secret does not exist"
I0818 12:59:53.204293       1 conditions.go:203] Setting lastTransitionTime for Certificate "argocd-ingress-tls" condition "Issuing" to 2024-08-18 12:59:53.20428469 +0000 UTC m=+73.659101125
I0818 12:59:53.213394       1 reflector.go:359] Caches populated for *v1.Issuer from k8s.io/client-go@v0.30.1/tools/cache/reflector.go:232
I0818 12:59:53.275197       1 reflector.go:359] Caches populated for *v1.ClusterIssuer from k8s.io/client-go@v0.30.1/tools/cache/reflector.go:232
I0818 12:59:53.683291       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Approved" to 2024-08-18 12:59:53.68327869 +0000 UTC m=+74.138095125
I0818 12:59:53.706428       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Ready" to 2024-08-18 12:59:53.706416845 +0000 UTC m=+74.161233280
I0818 12:59:53.706857       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Ready" to 2024-08-18 12:59:53.706836673 +0000 UTC m=+74.161653108
I0818 12:59:53.707347       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Ready" to 2024-08-18 12:59:53.70732659 +0000 UTC m=+74.162143015
I0818 12:59:53.707680       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Ready" to 2024-08-18 12:59:53.707663836 +0000 UTC m=+74.162480261
I0818 12:59:53.707812       1 conditions.go:263] Setting lastTransitionTime for CertificateRequest "argocd-ingress-tls-1" condition "Ready" to 2024-08-18 12:59:53.707794669 +0000 UTC m=+74.162611104
I0818 12:59:53.733997       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls-1" error="Operation cannot be fulfilled on certificaterequests.cert-manager.io \"argocd-ingress-tls-1\": the object has been modified; please apply your changes to the latest version and try again"
I0818 12:59:53.738630       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls-1" error="Operation cannot be fulfilled on certificaterequests.cert-manager.io \"argocd-ingress-tls-1\": the object has been modified; please apply your changes to the latest version and try again"
I0818 12:59:53.749294       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls-1" error="Operation cannot be fulfilled on certificaterequests.cert-manager.io \"argocd-ingress-tls-1\": the object has been modified; please apply your changes to the latest version and try again"
I0818 12:59:53.750138       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls-1" error="Operation cannot be fulfilled on certificaterequests.cert-manager.io \"argocd-ingress-tls-1\": the object has been modified; please apply your changes to the latest version and try again"
I0818 12:59:54.863359       1 setup.go:113] "generating acme account private key" logger="cert-manager.controller" resource_name="issuer" resource_namespace="" resource_kind="ClusterIssuer" resource_version="v1" related_resource_name="issuer" related_resource_namespace="cert-manager" related_resource_kind="Secret"
I0818 12:59:55.029403       1 setup.go:225] "ACME server URL host and ACME private key registration host differ. Re-checking ACME account registration" logger="cert-manager.controller" resource_name="issuer" resource_namespace="" resource_kind="ClusterIssuer" resource_version="v1" related_resource_name="issuer" related_resource_namespace="cert-manager" related_resource_kind="Secret"
I0818 12:59:55.701163       1 setup.go:315] "verified existing registration with ACME server" logger="cert-manager.controller" resource_name="issuer" resource_namespace="" resource_kind="ClusterIssuer" resource_version="v1" related_resource_name="issuer" related_resource_namespace="cert-manager" related_resource_kind="Secret"
I0818 12:59:55.701447       1 conditions.go:96] Setting lastTransitionTime for Issuer "issuer" condition "Ready" to 2024-08-18 12:59:55.701435272 +0000 UTC m=+76.156251747
I0818 12:59:55.724846       1 setup.go:208] "skipping re-verifying ACME account as cached registration details look sufficient" logger="cert-manager.controller" resource_name="issuer" resource_namespace="" resource_kind="ClusterIssuer" resource_version="v1" related_resource_name="issuer" related_resource_namespace="cert-manager" related_resource_kind="Secret"
I0818 12:59:55.755315       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls-1" error="Operation cannot be fulfilled on certificaterequests.cert-manager.io \"argocd-ingress-tls-1\": the object has been modified; please apply your changes to the latest version and try again"
I0818 13:00:00.035844       1 setup.go:208] "skipping re-verifying ACME account as cached registration details look sufficient" logger="cert-manager.controller" resource_name="issuer" resource_namespace="" resource_kind="ClusterIssuer" resource_version="v1" related_resource_name="issuer" related_resource_namespace="cert-manager" related_resource_kind="Secret"
I0818 13:01:30.601194       1 acme.go:233] "certificate issued" logger="cert-manager.controller.sign" resource_name="argocd-ingress-tls-1" resource_namespace="argocd" resource_kind="CertificateRequest" resource_version="v1" related_resource_name="argocd-ingress-tls-1-1427111713" related_resource_namespace="argocd" related_resource_kind="Order" related_resource_version="v1"
I0818 13:01:30.601433       1 conditions.go:252] Found status change for CertificateRequest "argocd-ingress-tls-1" condition "Ready": "False" -> "True"; setting lastTransitionTime to 2024-08-18 13:01:30.601422936 +0000 UTC m=+171.056239371
I0818 13:01:30.689246       1 conditions.go:192] Found status change for Certificate "argocd-ingress-tls" condition "Ready": "False" -> "True"; setting lastTransitionTime to 2024-08-18 13:01:30.689206499 +0000 UTC m=+171.144022934
I0818 13:01:30.721880       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls" error="Operation cannot be fulfilled on certificates.cert-manager.io \"argocd-ingress-tls\": the object has been modified; please apply your changes to the latest version and try again"
I0818 13:01:30.723346       1 conditions.go:192] Found status change for Certificate "argocd-ingress-tls" condition "Ready": "False" -> "True"; setting lastTransitionTime to 2024-08-18 13:01:30.72333533 +0000 UTC m=+171.178151765
I0818 13:01:30.748220       1 controller.go:157] "re-queuing item due to optimistic locking on resource" logger="cert-manager.controller" key="argocd/argocd-ingress-tls" error="Operation cannot be fulfilled on certificates.cert-manager.io \"argocd-ingress-tls\": the object has been modified; please apply your changes to the latest version and try again"
```
