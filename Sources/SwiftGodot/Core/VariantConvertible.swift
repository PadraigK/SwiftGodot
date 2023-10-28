//
//  Convertible.swift
//
//
//  Created by Padraig O Cinneide on 2023-10-22.
//

@_implementationOnly import GDExtension
 
/// Types that can be converted in the types that can be wrapped in a Variant
public protocol VariantConvertible {
    func toVariantRepresentable() -> VariantRepresentable
}

extension Variant {
    public convenience init(_ value: some VariantConvertible) {
        self.init(value.toVariantRepresentable())
    }
}

extension String: VariantConvertible {
    public func toVariantRepresentable() -> VariantRepresentable {
        GString(stringLiteral: self)
    }
}

extension Bool: VariantConvertible {
    public func toVariantRepresentable() -> VariantRepresentable {
        GDExtensionBool(self ? 1 : 0)
    }
}
