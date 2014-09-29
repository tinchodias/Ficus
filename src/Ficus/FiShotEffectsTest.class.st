Class {
	#name : #FiShotEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-Effects'
}

{ #category : #tests }
FiShotEffectsTest >> testNoEffect [

	| edit effect source result |
	source := FiChef nickname: #A.

	edit :=  source at: #nickname equal: #A.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
]

{ #category : #tests }
FiShotEffectsTest >> testUpdate [

	| edit effect source result |
	source := FiChef nickname: #A.

	edit :=  source at: #shortBio equal: '42'.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect oldValue equals: ''.
	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #shortBio equal: '').
]

{ #category : #tests }
FiShotEffectsTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit effect result |
	source := FiChef nickname: #A.

	editAdmiredChefs := 
		source 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs include: #X ].
	editShortBio := 
		source
			at: #shortBio
			equal: '42'.

	edit := source edits: { editAdmiredChefs. editShortBio }.			
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self 
		assert: effect inverse 
		equals: (result edits: {(source effectOf: editAdmiredChefs) inverse. (source effectOf: editShortBio) inverse }).
	
	self flag: #todo. "Smells bad that both oldValues are the old comment..."
	self assert: (source effectOf: editShortBio) edit equals: editShortBio.
	self assert: (source effectOf: editShortBio) oldValue equals: ''.
]
