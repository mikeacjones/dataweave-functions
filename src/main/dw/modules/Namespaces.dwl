%dw 2.0
fun appendNamespace(data, nsSelector: (k: Key) -> Namespace | Null) = data match {
    case is Array -> data map appendNamespace($, nsSelector)
    case is Object -> data mapObject do {
        var ns0 = nsSelector($$)
        ---
        if (ns0 != null) ns0#"$($$)" : $
        else ($$) : $
    }
    else -> $
}