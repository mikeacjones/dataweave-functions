# Dataweave Functions

These represent a set of dataweave functions I plan to either make use of again, or revisit in the future as references.

## Namespaces
---
#### appendNamespace(data: Any, nsSelector: (k: Key) -> Namespace | Null)

Function to append XML namespaces to object keys.

#### Example #1

Input:
```json
{
  "GetOrderById": {
    "OrderId": 656734
  }
}
```

Dataweave:
```dataweave
%dw 2.0
import dw::modules::Namespaces
output application/xml
ns soapenv http://schemas.xmlsoap.org/soap/envelope/
ns tem http://tempuri.org/
---
soapenv#Envelop: {
    soapenv#Header: null,
    soapenv#Body: payload Namespaces::appendNamespace tem
}
```

Output:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<soapenv:Envelop xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header/>
  <soapenv:Body>
    <tem:GetOrderById xmlns:tem="http://tempuri.org/">
      <tem:OrderId>656734</test:OrderId>
    </tem:GetOrderById>
  </soapenv:Body>
</soapenv:Envelop>
```

#### Example #2 (using more custom mapping)

Input:

```json
{
  "GetOrderById": {
    "OrderId": 656734
  }
}
```

Dataweave:
```dataweave
%dw 2.0
import dw::modules::Namespaces
output application/xml
ns soapenv http://schemas.xmlsoap.org/soap/envelope/
ns tem http://tempuri.org/
ns test http:/test.com/

var nsMap = {
  "OrderId": test
}
---
soapenv#Envelop: {
    soapenv#Header: null,
    soapenv#Body: payload Namespaces::appendNamespace (nsMap[$] default tem)
}
```

Output:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<soapenv:Envelop xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header/>
  <soapenv:Body>
    <tem:GetOrderById xmlns:tem="http://tempuri.org/">
      <test:OrderId xmlns:test="http://test.com/">656734</test:OrderId>
    </tem:GetOrderById>
  </soapenv:Body>
</soapenv:Envelop>
```