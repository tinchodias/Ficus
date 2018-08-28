Extension { #name : #FiObject }

{ #category : #'*Ficus2-Updates' }
FiObject >> changeFrom: other [

	^ self subclassResponsibility 
]

{ #category : #'*Ficus2-Updates' }
FiObject >> changeOf: anEdit [ 

	^ anEdit changeOn: self
]

{ #category : #'*Ficus2-Updates' }
FiObject >> changeOfCompositeEdit: aCompositeEdit [ 

	^ FiCompositeChange builder
		children: (aCompositeEdit children values collect: [ :anEdit | anEdit changeOn: self ]) asFiSet;
		new
]

{ #category : #'*Ficus2-Updates' }
FiObject >> changeOfSubEdit: aSubEdit [ 

	self flag: #fix. "inefficient".
	
	^ (self resultOf: aSubEdit) changeFrom: self
]

{ #category : #'*Ficus2-Updates' }
FiObject >> editAll: aCollectionOfEdits [
	
	^ FiEdit fromAll: aCollectionOfEdits
]

{ #category : #'*Ficus2-Updates' }
FiObject >> editAt: step do: aBlockClosure [ 

	^ self subclassResponsibility
]

{ #category : #'*Ficus2-Updates' }
FiObject >> editAtPath: aPath do: aBlockClosure [

	| target edit |
	target := aPath resolvedOn: self.
	edit := aBlockClosure value: target.

	^ aPath length isZero
		ifTrue: [ edit ]
		ifFalse: [ FiSubEdit path: aPath edit: edit ]
]

{ #category : #'*Ficus2-Updates' }
FiObject >> editFromSimpleChanges: simpleChanges [
	"Convert as edit, assuming the FiSimpleChange applies to myself *as root*."

	^ self editAll: (simpleChanges collect: [ :each | 
		self 
			editAtPath: each path basePath "skip the last step of the path of the simple change"
			do: [ :target | target editFromSimpleChange: each ]])
]

{ #category : #'*Ficus2-Updates' }
FiObject >> ficusDeepCollect: aBlock basePath: aPath [

	| collectionFromChildren |
	collectionFromChildren := 
		Array streamContents: [ :stream |	
			self stepsAndValuesDo: [ :step :value | 
				stream nextPut: (value ficusDeepCollect: aBlock basePath: (aPath / step)) ]].

	^ aBlock 
		value: self 
		value: aPath 
		value: collectionFromChildren
]

{ #category : #'*Ficus2-Updates' }
FiObject >> ficusDeepDo: aBlock basePath: aPath [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock basePath: (aPath / step) ].

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #'*Ficus2-Updates' }
FiObject >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit children values
		inject: self
		into: [ :copy :edit | copy resultOf: edit ]
]

{ #category : #'*Ficus2-Updates' }
FiObject >> resultOfSubEdit: aSubEdit [ 
	
	^ self 
		resultOfSubEdit: aSubEdit
		steps: (aSubEdit path asPathOn: self) steps
]

{ #category : #'*Ficus2-Updates' }
FiObject >> resultOfSubEdit: aSubEdit steps: anArrayOfSteps [
	
	| anEdit |
	anEdit := anArrayOfSteps 
		ifEmpty: [ aSubEdit edit ]
		ifNotEmpty: [ 
			self 
				editAt: anArrayOfSteps first
				do: [ :aValue | 
					FiEqual value: 
						(aValue 
							resultOfSubEdit: aSubEdit 
							steps: anArrayOfSteps allButFirst) ] ].
					
	^ self resultOf: anEdit
]
