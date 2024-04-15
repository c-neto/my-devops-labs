
provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "root"
}

# vault auth list
# >>> https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend
resource "vault_auth_backend" "cluster-dev" {
  type = "kubernetes"
  path = "cluster-dev"
}

# vault auth list
# >>> https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_config
resource "vault_kubernetes_auth_backend_config" "cluster-dev" {
  backend                = vault_auth_backend.cluster-dev.path
  kubernetes_host        = "https://vault-client-control-plane:6443"
  kubernetes_ca_cert     = "-----BEGIN CERTIFICATE-----\nMIIC/jCCAeagAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl\ncm5ldGVzMB4XDTI0MDQxNDIxMzA1MVoXDTM0MDQxMjIxMzA1MVowFTETMBEGA1UE\nAxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL0/\nIaVKEGKSNVtE40zAS4qcPJZLPgBCL666whMks+WLOY9+jww9QP7rQvngfnXYut0H\npxGRRFAgt7klQg1KZW/VR9mL3xBHNmF6SFSz6ZFiFX4/1vtf8tSrZShy0j5uQp+Q\nzE2rzDAFvrvagehRy/DzGbQio0wIO0R3LoUpLHM7Fkm4jrTAw7VIashUKcAfpdrP\nLqIva99rDfLZq11Lg3nevCqJX6oHHNQfi/MWT+KR0GkQnkJFWeFeGWJD+ETZS52o\ni0Skm/Le/6OsPLFcQJYF7j4LNcT1tlIB4NTJxFXwY4bq6WmKufjUvms9fDOOp+xo\nOMN4m3gLFgTqGj6cOR0CAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB\n/wQFMAMBAf8wHQYDVR0OBBYEFPUNdwddFlw+S7ha6r6V+v9yHkCXMBUGA1UdEQQO\nMAyCCmt1YmVybmV0ZXMwDQYJKoZIhvcNAQELBQADggEBAGTxX8XxknHz3yGpDS22\n5hvkZIDzmgdG/7MaUh43wTGymRf/tLY05HwFaCoyZaDvkE6yrtZwH9xt4TUUuTxi\nP3+x7qkVEX3fKzhCV0a8RMPhunOwYohc8PDhZOTAb3paUGbgtI66VWQjBO6MnjJg\ncv7k+PWKvxYzG2oFYlMIUp07UyQt9Efog2MjITKoHsveY2hNUifQIyLeTIuMrjgR\nTebEipPP922lMXTXz+bOq0lr5eAdngLC7TaVUitYrpj/PozoQcVk4NqfROdm+weY\nk4hm/bV8qDmF/AQGlIKdA0gZJaARI3b//ZVs7911zzSZh779lysdx+6pbjwtJX0T\nIJE=\n-----END CERTIFICATE-----\n"
  disable_local_ca_jwt   = "true"
}

# vault secrets list
resource "vault_mount" "secrets-dev" {
  path        = "secrets-dev"
  type        = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "This is an example KV Version 2 secret engine mount"
}

# vault policy list
# vault policy read secrets-foo-policy
resource "vault_policy" "secrets-dev-ro" {
  name   = "secrets-dev-ro"
  policy = <<EOF
path "${vault_mount.secrets-dev.path}/*" {
  capabilities = [
    "read"
  ]
}
EOF
}

# >>> https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role
resource "vault_kubernetes_auth_backend_role" "cluster-dev-ro" {
  backend                          = vault_auth_backend.cluster-dev.path
  role_name                        = "cluster-dev-ro"
  bound_service_account_names      = ["app-sa"]
  bound_service_account_namespaces = ["app"]
  token_ttl                        = 3600
  token_policies                   = [
    vault_policy.secrets-dev-ro.name
  ]
}

# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret
resource "vault_generic_secret" "secrets-dev-properties" {
  path = "${vault_mount.secrets-dev.path}/properties"
  data_json = <<EOT
{
  "username": "foo",
  "password": "bar"
}
EOT
}
