# create-dns-record

Adds records to a domain using AWS Route53

## Example

```hcl
module "create_a_record" {
  source = "./modules/aws/create-dns-record"

  domain = "domain.com"
  type = "A"
  record = {
    "domain.com" = "192.168.0.1"
  }
}
```

## Arguments

| Name                      | Required | Value Type | Description
|---------------------------| -------- | ---------- | -----------
|`domain`                   | Yes      | String     | The domain to add records to
|`type`                     | Yes      | String     | The record type to add. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
|`records`                  | Yes      | Map        | A map of records to add. Domains as keys and IPs as values.
|`ttl`                      | No       | Integer    | The TTL of the record(s). Default value is 300

## Outputs

| Name                      | Value Type | Description
|---------------------------| ---------- | -----------
|`records`                  | Map        | Map containing the records added to the domain. Domains as keys and IPs as values.

