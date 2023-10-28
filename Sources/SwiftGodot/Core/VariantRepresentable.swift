//
//  VariantRepresentable.swift
//
//
//  Created by Padraig O Cinneide on 2023-10-22.
//

/// Types that Variant can hold directly 1:1 with no conversion
public protocol VariantRepresentable {
    /// The godot storage type
    static var godotType: Variant.GType { get }
    
    /// Creates an instance using a variant
    init?(_ variant: Variant)
}

extension VariantRepresentable {
    public init?(_ variant: Variant) {
        /*
         if kind == .isClass {
             p("public static func unwrap(variant: Variant) -> \(typeName)?") {
                 p("guard variant.gtype == .\(gtype) else { return nil }")
                 p ("var localContent: \(typeName).ContentType = \(typeName).zero")
                 p ("variant.toType(.\(gtype), dest: &localContent)")
                 p ("return \(typeName)(content: localContent)")
             }
         } else {
             p("public static func unwrap(variant: Variant) -> Self?") {
                 p("guard variant.gtype == .\(gtype) else { return nil }")
                 p("var value = \(bc.name)()")
                 p("variant.toType(.\(gtype), dest: &value)")
                 p("return value")
             }
         }
         */
        
        guard Self.godotType == variant.gtype else {
            return nil
        }
        
        if let contentTypeStoringSelf = Self.self as? any ContentTypeStoring.Type {
            var content = contentTypeStoringSelf.zero
            withUnsafeMutablePointer(to: &content) { ptr in
                variant.toType(Self.godotType, dest: ptr)
            }
        } else {
            
        }
        
    }
}

extension UInt8: VariantRepresentable {
    public static var godotType: Variant.GType { .bool }
}

extension Int64: VariantRepresentable {
    public static var godotType: Variant.GType { .int }
}

extension Double: VariantRepresentable {
    public static var godotType: Variant.GType { .float }
}

extension GString: VariantRepresentable {
    public static var godotType: Variant.GType { .string }
}

extension Vector2: VariantRepresentable {
    public static var godotType: Variant.GType { .vector2 }
}

extension Vector2i: VariantRepresentable {
    public static var godotType: Variant.GType { .vector2i }
}

extension Rect2: VariantRepresentable {
    public static var godotType: Variant.GType { .rect2 }
}

extension Rect2i: VariantRepresentable {
    public static var godotType: Variant.GType { .rect2i }
}

extension Vector3: VariantRepresentable {
    public static var godotType: Variant.GType { .vector3 }
}

extension Vector3i: VariantRepresentable {
    public static var godotType: Variant.GType { .vector3i }
}

extension Transform2D: VariantRepresentable {
    public static var godotType: Variant.GType { .transform2d }
}

extension Vector4: VariantRepresentable {
    public static var godotType: Variant.GType { .vector4 }
}

extension Vector4i: VariantRepresentable {
    public static var godotType: Variant.GType { .vector4i }
}

extension Plane: VariantRepresentable {
    public static var godotType: Variant.GType { .plane }
}

extension Quaternion: VariantRepresentable {
    public static var godotType: Variant.GType { .quaternion }
}

extension AABB: VariantRepresentable {
    public static var godotType: Variant.GType { .aabb }
}

extension Basis: VariantRepresentable {
    public static var godotType: Variant.GType { .basis }
}

extension Transform3D: VariantRepresentable {
    public static var godotType: Variant.GType { .transform3d }
}

extension Projection: VariantRepresentable {
    public static var godotType: Variant.GType { .projection }
}

extension Color: VariantRepresentable {
    public static var godotType: Variant.GType { .color }
}

extension NodePath: VariantRepresentable {
    public static var godotType: Variant.GType { .nodePath }
}

extension StringName: VariantRepresentable {
    public static var godotType: Variant.GType { .stringName }
}

extension RID: VariantRepresentable {
    public static var godotType: Variant.GType { .rid }
}

extension Callable: VariantRepresentable {
    public static var godotType: Variant.GType { .callable }
}

extension Signal: VariantRepresentable {
    public static var godotType: Variant.GType { .signal }
}

extension GDictionary: VariantRepresentable {
    public static var godotType: Variant.GType { .dictionary }
}

extension GArray: VariantRepresentable {
    public static var godotType: Variant.GType { .array }
}

extension PackedByteArray: VariantRepresentable {
    public static var godotType: Variant.GType { .packedByteArray }
}

extension PackedInt32Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedInt32Array }
}

extension PackedInt64Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedInt64Array }
}

extension PackedFloat32Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedFloat32Array }
}

extension PackedFloat64Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedFloat64Array }
}

extension PackedStringArray: VariantRepresentable {
    public static var godotType: Variant.GType { .packedStringArray }
}

extension PackedVector2Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedVector2Array }
}

extension PackedVector3Array: VariantRepresentable {
    public static var godotType: Variant.GType { .packedVector3Array }
}

extension PackedColorArray: VariantRepresentable {
    public static var godotType: Variant.GType { .packedColorArray }
}

extension Object: VariantRepresentable {
    public static var godotType: Variant.GType { .object }
}
