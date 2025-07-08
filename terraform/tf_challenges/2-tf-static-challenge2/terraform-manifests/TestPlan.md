# TestPlan for TF Static Site

FYI output will spit out test url

ogsjlmyd.z13.web.core.windows.net

# June 5th

## Results

│ Error: creating Blob "index.html" (Account "Account \"ogsjlmyd\" (IsEdgeZone false / ZoneName \"\" / Subdomain Type \"blob\" / DomainSuffix \"core.windows.net\")" / Container Name "$web"): PutBlockBlobFromFile: putting bytes: executing request: unexpected status 404 (404 The specified container does not exist.) with ContainerNotFound: The specified container does not exist.
│ RequestId:d3df3325-e01e-0001-2642-d62974000000
│ Time:2025-06-05T17:49:57.6771695Z

Site did not have index.html uploads to $web container.  
Manually updated and it works.

## Attempted solution

comment out # resource "azurerm_storage_blob" "example" {

I think this worked....but not sure

## 2nd Result

No TF error, but no uploaded index.html

### FIX

Bandaid is to use tf and call local file(s)

Future: - Use gitlab pipeline.

## 3rd Result

### CHANGES

Uncommented  
resource "azurerm_storage_blob" "example"

It has an source property

### YEAH .....it worked...

It doesn't upload custom_not_found.html

## 4th Result

### Changes

added for_each for each html page

### YEAH .....it worked...
