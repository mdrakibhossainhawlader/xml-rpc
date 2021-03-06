/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

import XML
import struct Foundation.Date
import struct Foundation.Data

extension XML.Element {
    init(rpcValue value: RPCValue) {
        switch value {
        case .int(let value): self.init(rpcValue: value)
        case .bool(let value): self.init(rpcValue: value)
        case .string(let value): self.init(rpcValue: value)
        case .double(let value): self.init(rpcValue: value)
        case .date(let value): self.init(rpcValue: value)
        case .base64(let value): self.init(rpcValue: value)
        case .array(let values): self.init(rpcValues: values)
        case .struct(let values): self.init(rpcValues: values)
        }
    }
}

extension XML.Element {
    init(rpcValue value: Int) {
        self.init(name: "int")
        self.value = String(value)
    }
}

extension XML.Element {
    init(rpcValue value: Bool) {
        self.init(name: "boolean")
        self.value = value ? "1" : "0"
    }
}

extension XML.Element {
    init(rpcValue value: String) {
        self.init(name: "string")
        self.value = value
    }
}

extension XML.Element {
    init(rpcValue value: Double) {
        self.init(name: "double")
        self.value = String(value)
    }
}

extension XML.Element {
    init(rpcValue value: Date) {
        self.init(name: "dateTime.iso8601")
        self.value = value.iso8601String
    }
}

extension XML.Element {
    init(rpcValue value: [UInt8]) {
        self.init(name: "base64")
        self.value = Data(value).base64EncodedString()
    }
}

extension XML.Element {
    init(rpcValues values: [RPCValue]) {
        self.init(name: "array")
        var data = XML.Element(name: "data")
        for value in values {
            var valueXml = XML.Element(name: "value")
            valueXml.children.append(.element(XML.Element(rpcValue: value)))
            data.children.append(.element(valueXml))
        }
        self.children.append(.element(data))
    }
}

extension XML.Element {
    init(rpcValues values: [String : RPCValue]) {
        self.init(name: "struct")

        for (key, value) in values {
            var member = XML.Element(name: "member")
            member.children.append(name: "name", value: key)

            var valueXml = XML.Element(name: "value")
            valueXml.children.append(XML.Element(rpcValue: value))
            member.children.append(valueXml)

            self.children.append(member)
        }
    }
}
