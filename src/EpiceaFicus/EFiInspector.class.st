Class {
	#name : #EFiInspector,
	#superclass : #FiChangeInspector,
	#category : #'EpiceaFicus-UI'
}

{ #category : #'as yet unclassified' }
EFiInspector >> diffChunkMorphsFor: aSimpleChange [

	^ {self diffChunkMorphFor: aSimpleChange}
]

{ #category : #'as yet unclassified' }
EFiInspector >> displayMorphFor: aSimpleChange [
		
	| morphs builder |
	builder := FiMorphBuilder default.
	morphs := OrderedCollection new.

	morphs add: (builder spotMorphWith: aSimpleChange path asMetamodelSpot).
	
	self plugin 
		prepareChangeDescriptionMorphs: morphs 
		for: aSimpleChange.
	
	^ builder rowMorphWithAll: morphs
]

{ #category : #'as yet unclassified' }
EFiInspector >> initializePresenterTreeModel [
	
	super initializePresenterTreeModel.
	
	treeModel
		childrenBlock: [ :aSimpleChange | #() ]
]

{ #category : #'as yet unclassified' }
EFiInspector >> treeRootsFor: anChange [

	^ anChange asSimpleChanges asArray flatCollect: [ :each | each relevantSimpleChanges ]
	
]
