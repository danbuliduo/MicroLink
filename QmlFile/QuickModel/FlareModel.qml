import QtQuick
import QtQuick.Controls
import QtQuick3D
import QtQuick3D.Effects
import QtQuick.Timeline
import QtQuick3D.Particles3D
View3D {
    id: view3D
    anchors.fill: parent
    environment: sceneEnvironment
    SceneEnvironment {
        id: sceneEnvironment
        effects: hDRBloomTonemap
        antialiasingQuality: SceneEnvironment.High
        antialiasingMode: SceneEnvironment.MSAA
        HDRBloomTonemap {
            id: hDRBloomTonemap
            gamma: 0.5
            exposure: 0.05
            blurFalloff: 3.5
            bloomThreshold: 0.7
        }
    }
    Node {
        id: scene
        DirectionalLight {
            id: directionalLight
            x: -109.673
            y: 144.4
            brightness: 1.04
            eulerRotation.z: -0.00001
            eulerRotation.y: 0
            eulerRotation.x: -31.84527
            z: 341.00067
        }

        PerspectiveCamera {
            id: camera
            x: -0
            y: -101.045
            z: 100.71584
        }
        ParticleSystem3D {
            id: particleSystem
            x: 0
            y: -102.103
            running: true
            z: -89.51989
            ParticleEmitter3D {
                id: particleEmitter
                particleRotationVelocityVariation.z:180
                particleRotationVelocityVariation.y: 180
                particleRotationVelocityVariation.x: 180
                particleRotationVariation.z: 180
                particleRotationVariation.x: 180
                particleRotationVariation.y: 181
                VectorDirection3D {
                    id: dir3d
                    direction.y: 0
                }
                SpriteParticle3D {
                    id: spriteParticle
                    color: "#ffffff"
                    colorVariation.y: 1
                    colorVariation.z: 1
                    colorVariation.w: 1
                    sprite: texture1
                    particleScale: 50
                    maxAmount: 100
                    Texture {
                        id: texture1
                        source: "qrc:/QmlFile/QuickModel/img/twirl_01.png"
                    }
                }
                velocity: dir3d
                lifeSpanVariation: 100
                particle: spriteParticle
                lifeSpan: 2000
                particleEndScale: 1.5
                particleScale: 1
                emitRate: 5
            }
            ParticleEmitter3D {
                id: particleEmitter1
                particleRotationVelocityVariation.z: 180
                particleRotationVelocityVariation.y: 180
                particleRotationVelocityVariation.x: 180
                particleRotationVariation.z: 180
                particleRotationVariation.y: 180
                particleRotationVariation.x: 181
                VectorDirection3D {
                    id: dir3d1
                    direction.y: 0
                }
                SpriteParticle3D {
                    id: spriteParticle1
                    color: "#ffffff"
                    colorVariation.y: 1
                    colorVariation.w: 0
                    colorVariation.x: 1
                    Texture {
                        id: texture2
                        source: "qrc:/QmlFile/QuickModel/img/twirl_02.png"
                    }
                    particleScale: 50
                    sprite: texture2
                    maxAmount: 100
                }
                velocity: dir3d1
                lifeSpanVariation: 100
                particle: spriteParticle1
                lifeSpan: 2000
                particleEndScale: 1.5
                particleScale: 1
                emitRate: 5
            }
        }
    }
}

