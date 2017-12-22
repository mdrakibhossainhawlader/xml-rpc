/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import XML
import Stream

extension RPCRequest {
    public func encode<T: UnsafeStreamWriter>(
        to stream: T,
        prettify: Bool = false
    ) throws {
        let document = XML.Document(rpcRequest: self)
        try document.encode(to: stream, prettify: prettify)
    }
}
