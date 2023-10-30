//
//  VariantStorable.swift
//
//
//  Created by Padraig O Cinneide on 2023-10-22.
//

@_implementationOnly import GDExtension
 
/// Something that can be wrapped in a Variant, either directly through `VariantRepresentable`
/// or by converting to a `VariantRepresentable`. 
public protocol VariantStorable {
    associatedtype Representable: VariantRepresentable
    
    /// Creates an instance using a variant
    init?(_ variant: Variant)
    
    func toVariantRepresentable() -> Representable
}

extension VariantStorable {
    /// Unwraps an object from a variant. This is useful when you want one method to call that
    /// will return the unwrapped Variant, regardless of whether it is a GodotObject or not.
    public static func makeOrUnwrap(_ variant: Variant) -> Self? {
        guard variant.gtype != .object else {
            return nil
        }
        return Self(variant)
    }

    /// Unwraps an object from a variant.
    public static func makeOrUnwrap(_ variant: Variant) -> Self? where Self: GodotObject {
        return variant.asObject()
    }
}

extension String: VariantStorable {
    public func toVariantRepresentable() -> GString {
        GString(stringLiteral: self)
    }
    
    public init?(_ variant: Variant) {
        guard let gString = GString(variant) else { return nil }
        self = gString.description
    }
}

extension Bool: VariantStorable {
    public func toVariantRepresentable() -> UInt8 {
        GDExtensionBool(self ? 1 : 0)
    }
    
    public init?(_ variant: Variant) {
        guard let gBool = GDExtensionBool(variant) else { return nil }
        self = gBool == 1
    }
}

extension Int: VariantStorable {
    public func toVariantRepresentable() -> Int64 {
        Int64(self)
    }
    
    public init?(_ variant: Variant) {
        guard let int = GDExtensionInt(variant) else { return nil }
        self = Int(int)
    }
}

