import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    Texture {
        id: _Users_dlawlor_Desktop_Coast_Guard_Patrol_Tow_Boat_Tow_Body_D_tga_texture
        generateMipmaps: true
        mipFilter: Texture.Linear
        // Source texture path expected: maps/Tow_Body_D.tga
        // Skipped property: source, reason: Failed to find texture at e:/Users/dlawlor/Desktop/Coast Guard Patrol Tow Boat/Tow_Body_D.tga
    }
    PrincipledMaterial {
        id: tow_body_material
        baseColor: "#ff999999"
        baseColorMap: _Users_dlawlor_Desktop_Coast_Guard_Patrol_Tow_Boat_Tow_Body_D_tga_texture
        indexOfRefraction: 1
    }

    // Nodes:
    Node {
        id: untitled_obj
        Node {
            id: tow
        }
        Model {
            id: default_
            source: "meshes/default_.mesh"
            materials: tow_body_material
        }
    }

    // Animations:
}
