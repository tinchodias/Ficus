Class {
	#name : #FiFixedObjectEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiFixedObjectEffectsTest >> testNoEffect [

	| edit effect source result |
	source := FiChef nickname: #A.

	edit :=  source editAt: #nickname equal: #A.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
]

{ #category : #tests }
FiFixedObjectEffectsTest >> testUpdate [

	| edit effect source result |
	source := FiChef nickname: #A.

	edit :=  source editAt: #shortBio equal: '42'.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect oldValue equals: ''.
	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result editAt: #shortBio equal: '').
]

{ #category : #tests }
FiFixedObjectEffectsTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit effect result |
	source := FiChef nickname: #A.

	editAdmiredChefs := 
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].
	editShortBio := 
		source
			editAt: #shortBio
			equal: '42'.

	edit := source editAll: { editAdmiredChefs. editShortBio }.			
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self 
		assert: effect inverse 
		equals: (result editAll: {(source effectOf: editAdmiredChefs) inverse. (source effectOf: editShortBio) inverse }).
	
	self flag: #todo. "Smells bad that both oldValues are the old comment..."
	self assert: (source effectOf: editShortBio) edit equals: editShortBio.
	self assert: (source effectOf: editShortBio) oldValue equals: ''.
]
