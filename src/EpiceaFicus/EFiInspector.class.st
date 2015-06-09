Class {
	#name : #EFiInspector,
	#superclass : #FiEffectInspector,
	#category : #'EpiceaFicus-UI'
}

{ #category : #'as yet unclassified' }
EFiInspector >> diffChunkMorphsFor: aSimpleEffect [

	^ {self diffChunkMorphFor: aSimpleEffect}
]

{ #category : #'as yet unclassified' }
EFiInspector >> displayMorphFor: aSimpleEffect [
		
	| morphs builder |
	builder := FiMorphBuilder default.
	morphs := OrderedCollection new.

	morphs add: (builder spotMorphWith: aSimpleEffect path asMetamodelSpot).
	
	self plugin 
		prepareEffectDescriptionMorphs: morphs 
		for: aSimpleEffect.
	
	^ builder rowMorphWithAll: morphs
]

{ #category : #'as yet unclassified' }
EFiInspector >> initializePresenterTreeModel [
	
	super initializePresenterTreeModel.
	
	treeModel
		childrenBlock: [ :aSimpleEffect | #() ]
]

{ #category : #'as yet unclassified' }
EFiInspector >> treeRootsFor: anEffect [

	^ anEffect asSimpleEffects asArray flatCollect: [ :each | each relevantSimpleEffects ]
	
]
